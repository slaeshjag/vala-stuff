VALAPKG	=	--pkg gdk-2.0 --pkg gtk+-2.0 --pkg webkit-1.0
SRC	=	browser_web_view.vala doris_window.vala doris.vala
BIN	=	doris.elf
VALAC	:=	valac
VALAFLAG=	-X -w

all:
	$(VALAC) $(VALAFLAG) $(VALAPKG) $(SRC) -o $(BIN)

clean:
	rm -f $(BIN)
