compile:
	bison -d code/validarContrasena.y
	flex code/validarContrasena.l
	gcc flex.c validarContrasena.tab.c -o validador.o -lfl -lm

