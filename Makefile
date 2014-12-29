SRC=.
ODIR=output
PFLAGS=--standalone --toc --mathjax

_OBJ=Intro.html About.html
OBJ=$(patsubst %,$(ODIR)/%,$(_OBJ))

all: compile

$(ODIR)/%.html: $(SRC)/%.md
	mkdir -p $(ODIR)
	pandoc --from=markdown --to=html5 $(PFLAGS) -o $@ $<

compile: $(OBJ)

clean:
	rm -rf $(ODIR)
