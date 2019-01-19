clc() {
    if [ $# -ge 1 ]; then
        printf '%s' "$@" | clc_parse
    else
        clc_parse
    fi
}

clc_escape() {
    sed -E 's,(\x1B\[[0-9;]*[a-zA-Z]),\\\[\1\\\],g'
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
