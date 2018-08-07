build_dir := build
outfile := guide
inputfiles = metadata.md README.md nodejs/introduction.md nodejs/project-structure.md golang/introduction.md mysql/mysql.md version-control/ssh-with-git.md

.PHONY: pdf createdir clean
pdf : createdir
	pandoc -s --toc --pdf-engine=xelatex -o $(build_dir)/$(outfile).pdf $(inputfiles)

createdir :
	mkdir -p $(build_dir)

clean :
	rm -r build/*
