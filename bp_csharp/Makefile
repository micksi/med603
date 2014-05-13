
bin = bin/
output = $(bin)BestPestCommandLine.exe
sources = BestPestCommandLine.cs BestPest.cs Range.cs

.PHONY: test

build: $(output)
	@echo '$(output) built successfully'

test: $(output)
	@mono $< testdata.csv

clean:
	@rm -f -r bin

$(output): $(sources)
	mkdir bin
	mcs $(sources) -out:$(output)




	
