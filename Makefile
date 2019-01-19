clc: src/*
	./make_bundle $^ > $@
	chmod +x $@
.DELETE_ON_ERROR:
