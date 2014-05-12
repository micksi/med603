
.PHONY: test

build: BestPestCommandLine.exe
	

test: BestPestCommandLine.exe
	@mono $< testdata.csv

clean:
	@rm -f *.exe

BestPestCommandLine.exe: BestPestCommandLine.cs BestPest.cs
	mcs -pkg:mono-options *.cs -out:BestPestCommandLine.exe




	
