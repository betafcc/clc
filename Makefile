define TEMPLATE
echo '#!/usr/bin/env bash'
source './src/clc.bash'
source './src/clc_code.bash'
declare | sed -n -e "/^_=/,\$$p" | sed -n -e "1d;p"
echo '
# run `clc` if not being sorced
# https://stackoverflow.com/a/2684300
[[ "$${BASH_SOURCE[0]}" = "$${0}" ]] && clc "$$@"
'
endef
export TEMPLATE


clc:
	env -i bash -c "$${TEMPLATE}" > $@
	chmod +x $@
.DELETE_ON_ERROR:
