# clc
Tiny bash utility for  coloring terminal output and prompt

![](./example.png)

Use `-e|--espace` to escape invisible characters (needed for use in PS1):

![](./example_prompt.png)

Colors:
- black
- red
- green
- yellow
- blue
- magenta
- cyan
- white
- rgb <0-255> <0-255> <0-255>

For background instead of foreground, just prepend 'bg' to color

Attrs:
- normal
- bold
- underline
- reverse
- invisible
- blink

Combine more than one command with `+`, eg `<bold + blue + bg red: hi>`
