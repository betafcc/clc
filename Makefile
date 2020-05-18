clc: src/*.bash
	env -i ./make_bundle $^ > $@
	chmod +x $@
.DELETE_ON_ERROR:
