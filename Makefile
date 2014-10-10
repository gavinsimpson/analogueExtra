# Get the version info for later
PKGVERS := $(shell sed -n "s/Version: *\([^ ]*\)/\1/p" DESCRIPTION)

all: check clean

#docs:
#	R -q -e 'library("roxygen2"); roxygenise(".")'

build: #docs
	cd ..;\
	R CMD build analogueExtra

check: build
	cd ..;\
	R CMD check analogueExtra_$(PKGVERS).tar.gz

check-cran: build
	cd ..;\
	R CMD check --as-cran analogueExtra_$(PKGVERS).tar.gz

install: build
	cd ..;\
	R CMD INSTALL analogueExtra_$(PKGVERS).tar.gz

move: check
	cp ../analogueExtra.Rcheck/analogueExtra-Ex.Rout ./tests/Examples/analogueExtra-Ex.Rout.save

clean:
	cd ..;\
	rm -r analogueExtra.Rcheck/
