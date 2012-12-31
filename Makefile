all: cloud_haskell.md
		pandoc --data-dir=datadir --self-contained -t slidy -s cloud_haskell.md -o cloud_haskell_slidy.html



clean:
		rm -rf *.html *.pdf
