SRC=.
ODIR=output
CSSDIR=$(SRC)/css
TEMPLATE=template/crypto-skeleton.html
PFLAGS=--toc --mathjax \
	   --template=$(TEMPLATE) \
	   --css=css/normalize.css \
	   --css=css/skeleton.css \
	   --css=css/custom.css

_OBJ=About.html \
	 0-Intro.html \
	 1-Background.html \
	 2-Probability.html
OBJ=$(patsubst %,$(ODIR)/%,$(_OBJ))

_CSS=normalize.css \
	 skeleton.css
CSS=$(patsubst %,$(CSSDIR)/%,$(_CSS))

all: compile

$(ODIR)/%.html: $(SRC)/%.md $(TEMPLATE)
	mkdir -p $(ODIR)
	pandoc --from=markdown --to=html5 $(PFLAGS) -o $@ $<

compile: $(OBJ) $(CSS)
	cp -r $(CSSDIR) $(ODIR)

clean:
	rm -rf $(ODIR)
