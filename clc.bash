clc() {
    if [ $# -ge 1 ]; then
        printf '%s' "$@" | clc_parse
    else
        clc_parse
    fi
}

clc_parse() (
    while IFS= read -n 1 -d '' char; do
        case "${char}" in
            '>') printf '\e[0m'; return 0;;
            '<') raw_code=$(clc_parse_directive)
                 printf '\e[%bm' "${raw_code}"
                 clc_parse "$@" "${raw_code}"
                 printf '\e[%bm' "$@";;
            *) printf '%b' "${char}";;
        esac
    done
)

clc_parse_directive() (
    IFS= read -r -d ':' directives;
    IFS=+
    for directive in ${directives}; do
        eval "clc_code_$(printf ${directive} | xargs)"
    done | paste -sd ';' -
)

clc_escape() {
    sed -E 's,(\x1B\[[0-9;]*[a-zA-Z]),\\\[\1\\\],g'
}

clc_declare_helpers() {  # maybe lazily load on first `clc` call?
    local key

    declare -gA clc_lookup_attr=(
        [normal]='0' [bold]='1' [underline]='4'
        [reverse]='7' [invisible]='8' [blink]='5'
    )

    declare -gA clc_lookup_color=(
        [black]='0' [red]='1' [green]='2' [yellow]='3'
        [blue]='4' [magenta]='5' [cyan]='6' [white]='7'
    )

    clc_code_rgb() { echo "${4-38};2;${1};${2};${3}"; }
    clc_code_attr() { echo "${clc_lookup_attr[${1}]}"; }
    clc_code_fg() { echo "3${clc_lookup_color[${1}]}"; }
    clc_code_bg() (
        if [ "${1}" = 'rgb' ]; then
            clc_code_rgb "${2}" "${3}" "${4}" 48
        else
            echo "4${clc_lookup_color[${1}]}"
        fi
    )

    for key in "${!clc_lookup_attr[@]}"; do
        eval "clc_code_${key}(){ clc_code_attr ${key}; }"
    done

    for key in "${!clc_lookup_color[@]}"; do
        eval "clc_code_${key}(){ clc_code_fg ${key}; }"
    done
}

clc_declare_helpers
