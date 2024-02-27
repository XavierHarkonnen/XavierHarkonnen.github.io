# git branch
BRANCH := main
# default commit message
MESSAGE := Automatically committed

# Markdown compiler
MDC := pandoc
# DocMark compiler
DMC := \#

# Markdown flags
MDFLAGS := --standalone --css=css/markdown/main.css
# DocMark flags
DMFLAGS := 

# build directories
MD_SRC := markdown/
DM_SRC := docmark/
MD_BLD := compiled_markdown/
DM_BLD := compiled_docmark/

# compile Markdown sources
COMPILE.md = $(MDC) $(MDFLAGS) -o $@ $<
# compile DocMark sources
COMPILE.dm = $(DMC) $(DMFLAGS) -o $@ $<

.DEFAULT_GOAL = all

# build
.PHONY: all
all: filestructure $(MD_COMPILED) $(DM_COMPILED)

# build file structure
.PHONY: filestructure
filestructure:
	mkdir -p $(MD_SRC)
	mkdir -p $(MD_BLD)
	mkdir -p $(DM_SRC)
	mkdir -p $(DM_BLD)

$(MD_BLD)%.html: $(MD_SRC)%.md
	$(COMPILE.md)

$(DM_BLD)%.html: $(DM_SRC)%.dm
	$(COMPILE.dm)

# force rebuild
.PHONY: remake
remake:
	$(MAKE) clean
	$(MAKE) all

# remove previous build
.PHONY: clean
clean:
	$(RM) $(wildcard $(MD_BLD)*.html)
	$(RM) $(wildcard $(DM_BLD)*.html)

# push changes to repository
.PHONY: commit
commit:
	git add .
	git commit -m "$(MESSAGE)"

# push changes to repository
.PHONY: push
push: commit
	git push origin $(BRANCH)

# pull changes from repository
.PHONY: pull
pull:
	git pull origin $(BRANCH)