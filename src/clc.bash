clc() {
  if [ $# -eq 0 ]; then
    clc_parse
  else
    case "${1}" in
      -v|--version) echo 'v1.1.0';;
      -e|--escape) shift; clc "$@" | sed -E 's,(\x1B\[[0-9;]*[a-zA-Z]),\\\[\1\\\],g';;
      *) printf '%s' "$@" | clc
    esac
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
