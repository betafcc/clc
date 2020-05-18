clc_code_rgb() {
  echo "38;2;${1};${2};${3}";
}

clc_code_bg() {
  local fg="$(clc_code_"${@}")"
  echo "4${fg:1}"
}

__clc_short_hands() {
  local key
  local -A lookup_attr=(
    [normal]='0' [bold]='1' [dim]='2' [italic]='3' [underline]='4'
    [blink]='5' [reverse]='7' [invisible]='8' [strike]='9'
  )
  local -A lookup_color=(
    [black]='0' [red]='1' [green]='2' [yellow]='3'
    [blue]='4' [magenta]='5' [cyan]='6' [white]='7'
  )

  for key in "${!lookup_attr[@]}"; do
    eval "clc_code_${key}(){ echo "${lookup_attr[${key}]}"; }"
  done

  for key in "${!lookup_color[@]}"; do
    eval "clc_code_${key}(){ echo "3${lookup_color[${key}]}"; }"
  done
}

__clc_short_hands
unset __clc_short_hands
