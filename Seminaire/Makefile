SHELL = /bin/bash
DATE = $(shell date +"%F-%H")

#  retrieve all source files
FIGS = $(shell find ./figs *.png *.jpg *.jpeg -type f)
TEX = $(shell find . -name "*.tex" -type f)
ASY = $(shell find ./figs -name "*.asy" -type f)
FIGS_TEX = $(shell find ./figs -name "*.tex" -type f)
JSON = $(shell find . -name "colors.json" -type f)
PDF = $(shell find ./figs -name "*.pdf" -type f)
STATES = $(shell find ./figs/states -name "*.dat" -type f)

SOURCE = $(TEX) $(FIGS) $(ASY) $(JSON)
STATES_FIGS = $(STATES:.dat=_wigner.pdf)
# Garbage files
GARBAGE_EXT = bbl synctex.gz synctex[(]busy[)] aux fdb_latexmk fls log tmp blg dvi out toc
AUTO_GARBAGE = $(shell find . -type f \( -false $(foreach ext,$(GARBAGE_EXT),-o -name "*.$(ext)") \))
MANUAL_GARBAGE = figs/gkp.pdf svg-inkscape/
GARBAGE = $(AUTO_GARBAGE) $(MANUAL_GARBAGE)


# Setting LaTeX compile (latexmk) options & flags
MK = latexmk

# Generate pdf version of document using pdflatex
OUT = pdf

# Run a file previewer and continually update the files
OUT_MODE = 

# Sets the generation of pdf files by pdflatex
GENERATOR = pdflatex
OPT = -interaction=batchmode -shell-escape # -shell-escape is necessary for svgs

# Asymptote outputs
ASY_OUTS = $(ASY:.asy=)
ASY_FIGS = $(ASY:.asy=.pdf)
	
# tex figs
TEX_FIGS = $(FIGS_TEX:.tex=.pdf)

HIDE = @
MAKE = make


# OS commands specific part
ifeq ($(OS), Windows_NT)
    RM = del /F /Q
    RMDIR = -RMDIR /S /Q
    MKDIR = -mkdir
else
    RM = -rm -rf
    RMDIR = -rm -rf
    MKDIR = -mkdir -p
endif

.PHONY: all $(MAIN).pdf clean targz zip

clean:
	$(HIDE)$(RM) $(AUTO_GARBAGE)

deepclean:
	$(HIDE)$(RM) $(GARBAGE) *.pdf **/*.pdf

targz:
	tar czf $(PROJECT)_$(DATE).tgz $(SOURCE) ./figs

zip:
	zip -q -r $(PROJECT)_$(DATE).zip $(SOURCE) ./figs

# Generate color files
AutoColors.sty.tmp:
	python3 scripts/convert_json.py --latex

figs/AutoColors.asy.tmp: colors.json
	python3 scripts/convert_json.py --asy

asy: $(ASY_FIGS)

# Generate figures
$(ASY_FIGS): %.pdf: %.asy figs/AutoColors.asy.tmp
	asy -f pdf $< -o $(basename $@)
	
$(TEX_FIGS): %.pdf: %.tex AutoColors.sty.tmp
	cd figs && lualatex $(notdir $(basename $<))

# for every .dat file in figs/states, run wigner.py
$(STATES_FIGS): %_wigner.pdf: %.dat .venv
	.venv/bin/python3 figs/states/wigner.py $(notdir $(basename $<))

figs: $(STATES_FIGS) $(ASY_FIGS) $(TEX_FIGS)

.venv: requirements.txt
	python3 -m venv .venv
	.venv/bin/pip install -r requirements.txt
