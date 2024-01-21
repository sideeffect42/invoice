PDFLATEX ?= pdflatex

TEXINPUTS = './:./packages//:'

# Signing
GPG ?= $(shell command -v gpg2 gpg | head -n 1)
GPG_KEY := 1234567890ABCDEF1234567890ABCDEF12345678


.PHONY: default
default: pdf

.PHONY: signed pdf
signed: rechnung.signed.pdf
pdf: rechnung.pdf

.PHONY: clean
clean:
	$(RM) rechnung.aux rechnung.log rechnung.out

%.pdf: _%.lco

%.pdf: %.tex
	TEXINPUTS=$(TEXINPUTS) $(PDFLATEX) $<

%.signed.pdf: %.pdf
ifeq (,$(GPG))
$(error GnuPG could not be found)
endif
	$(GPG) --local-user '$(GPG_KEY)' --clearsign --output=$@ $<
	$(GPG) --verify $@
