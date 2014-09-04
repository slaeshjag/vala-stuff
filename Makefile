VALAC	:=	valac
BIN	=	test.elf
VALAPKG	+=	--pkg gtk+-3.0 --pkg webkitgtk-3.0

SRCFILES	=	$(wildcard *.vala)

all:
	@echo " [INIT] bin/"
	@mkdir -p bin/
	@echo " [VALA] bin/$(BIN)"
	@$(VALAC) -o bin/$(BIN) $(SRCFILES) $(VALAPKG)

clean:
	@echo " [ RM ] bin/"
	@rm -rf bin/

