SUBDIRS= comprehensive-exam  # Sudirs that require building.

# Extensions to markdown
MARKDOWN_EXTS=table_captions\
	      grid_tables\
              pipe_tables


# command to convert into latex.

EXTS=$(shell echo ${MARKDOWN_EXTS}|sed 's/[ ]/+/g')
PANDOC= pandoc -N \
		-f markdown+${EXTS} \
		-t latex \


GENERATED_FILES= pdf tex aux log toc out
export PANDOC

# Phony targets. A natural question is why is phd-program.pdf a
# phony target. The pdf file depends on files in the subdirectory
# and needs to be compiled when any one of those change. Till
# I find a better way, it will remain a phony target.

.PHONY: all clean subdirs subdirs-clean phd-program.pdf

all: subdirs phd-program.pdf

phd-program.tex: phd-program.md
	${PANDOC} --toc -H preamble.tex -s phd-program.md -o phd-program.tex

phd-program.pdf: phd-program.tex
	pdflatex phd-program.tex
	pdflatex phd-program.tex
subdirs:
	$(foreach dir, ${SUBDIRS}, make -C ${dir} all;)

subdirs-clean:
	$(foreach dir, ${SUBDIRS}, make -C ${dir} clean;)

clean:  subdirs-clean
	rm -f $(addprefix phd-program.,${GENERATED_FILES})
