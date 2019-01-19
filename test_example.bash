source './clc'

clc '\
<rgb 255 255 255 + bg rgb 235 100 100:\
  hello<bold: world>,\
  <reverse: how are >\
  <underline: you?>  >
'

PS1=$(clc '\
<bold:\
<red:[\
<yellow:\\u>\
<green:@>\
<blue:\\h> \
<magenta:\\W>\
]>$ >' | clc_escape)
