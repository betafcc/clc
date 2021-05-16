# clc
Tiny bash utility for  coloring terminal output and prompt

![](./examples/usage.gif)

The motivating use case was easily stacking styles, which is not possible to do with other tools like [node's chalk](https://github.com/chalk/chalk-cli):

![](./examples/stacking.gif)

Useful for templating colorful prompts (use `-e|--escape` for this):

`PS1=$(clc -e '<bold:<red:[<yellow:\\u><green:@><blue:\\h><magenta:\\W>]>$ >')`

![](./examples/prompt.png)

## Try it

```bash
bash <(curl -s https://raw.githubusercontent.com/betafcc/clc/master/clc) '<red:hello <reverse:world>'
```

## Install

```bash
dest='/usr/local/bin/clc'; curl -s https://raw.githubusercontent.com/betafcc/clc/master/clc | sudo tee "${dest}" > /dev/null && sudo chmod +x "${dest}"
```

Then use:

```bash
clc '<red:hello <reverse:world>'
```

## More


### Use foreground colors:

```bash
clc '<red:hello>'
clc '<green:hello <blue: world>>'
clc '<rgb 255 120 120: hello>'
clc '<rgb 255 120 120: hello>'
clc '<#f66: hello>'
clc '<#66fa73: hello>'
```

### Use background colors:

```bash
clc '<bg red:hello>'
clc '<bg green:hello <bg blue: world>>'
clc '<bg rgb 255 120 120: hello>'
clc '<bg #66fa73: hello>'
```

### Use effects:

```bash
clc '<bold:hello>'
clc '<bold:hello <underline: world>>'
```

### Combine commands:

```bash
clc '<red + bg blue + underline + bold:hello>'
```

### Available Colors:
- black
- red
- green
- yellow
- blue
- magenta
- cyan
- white
- rgb <0-255> <0-255> <0-255>
- #000 - #fff
- #000000 - #ffffff

### Available effects:
- normal
- bold
- dim
- strike
- italic
- underline
- reverse
- invisible
- blink

### Version:

```bash
clc -v
clc --version
```
