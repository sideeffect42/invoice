PDFLATEX ?= pdflatex

# Signing
GPG ?= $(shell command -v gpg2 gpg | head -n 1)
GPG_KEY := 1234567890ABCDEF1234567890ABCDEF12345678


.PHONY: default
default: pdf

.PHONY: signed pdf
signed: rechnung-signed.pdf
pdf: rechnung.pdf

%.pdf: %.tex
	TEXINPUTS=".$(shell find ./packages -maxdepth 1 -type d -printf ':%p'):" $(PDFLATEX) '$<'

.PHONY: clean
clean:
	$(RM) rechnung.aux rechnung.log rechnung.out

rechnung.pdf: _rechnung.lco

rechnung-signed.pdf: rechnung.pdf
ifeq (,$(GPG))
$(error GnuPG could not be found)
endif
	$(GPG) --local-user '$(GPG_KEY)' --clearsign --output='$@' '$<'
