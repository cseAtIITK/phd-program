.PHONY: all clean

all: report.tex

report.tex: report.md
	${PANDOC} report.md  -o report.tex

clean:
	rm -f report.tex report.aux
