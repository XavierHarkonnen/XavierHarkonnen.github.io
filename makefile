# git branch
BRANCH := master
# default commit message
MESSAGE := Automatically committed

# Markdown compiler
MDC := pandoc
# DocMark compiler
DMC := \#

# Markdown flags
MDFLAGS := 
# DocMark flags
DMFLAGS := 

# build directories
MD_SRC := markdown/
DM_SRC := docmark/
MD_BLD := compiled_markdown/
DM_BLD := compiled_docmark/

# source files
MD_SOURCES := $(wildcard $(MD_SRC)*.md)
DM_SOURCES := $(wildcard $(DM_SRC)*.dm)

# compiled files
MD_COMPILED := $(subst md,html,$(subst $(MD_SRC),$(MD_BLD),$(MD_SOURCES)))
DM_COMPILED := $(subst dm,html,$(subst $(DM_SRC),$(DM_BLD),$(DM_SOURCES)))

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

$(MD_COMPILED): $(MD_SOURCES)
	$(COMPILE.md)

$(DM_COMPILED): $(DM_SRC) $(DM_BLD) $(DM_SOURCES)
	$(COMPILE.dm)

# force rebuild
.PHONY: remake
remake:
	$(MAKE) clean
	$(MAKE) all

# remove previous build
.PHONY: clean
clean:
	$(RM) $(MD_COMPILED)
	$(RM) $(DM_COMPILED)

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