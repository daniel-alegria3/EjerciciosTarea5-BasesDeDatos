
output: main.tex
	# tectonic main.tex ${tec_defs} ${tec_args} #OFICIAL LINE
	tectonic main.tex ${tec_defs} -Z shell-escape-cwd=${PWD}

all: minted output

code.tex: ./code/t*.sql
	cat ./code/t*.sql > code.tex
	sed -i "s/--- //g" code.tex
	sed -i '1 i\\\begin{enumerate}' code.tex
	printf '\\end{enumerate}\n' >> code.tex
	tec_defs="\def\MINTED{} \input{main.tex}" # put this to 'turn on' minted
	tec_args="-Z shell-escape-cwd=${PWD}"

clean:
	rm -f main.aux main.log main.pyg main.xdv main.out

.PHONY: clean all

