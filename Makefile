INC = constants.inc header.inc guard_registry.mac
SRC = main.s reset.s
OBJ = ${SRC:.s=.o}
CFG = nes.cfg

all: output.nes
	/Applications/fceux.app/Contents/MacOS/fceux output.nes

output.nes: ${CFG} ${OBJ}
	ld65 -C $(CFG) ${OBJ} -o output.nes

main.o: main.s ${INC}
	ca65 main.s -o main.o

%.o: %.s ${SRC} ${INC}
	ca65 $< -o $@

clean:
	rm *.nes *.o
