#!/bin/bash

for FILE in ./*.pdf; do
  pdfcrop "${FILE}"
done

find . -mindepth 1 -maxdepth 1 ! -name "*-crop.pdf" -delete

pdfjam $(ls *-crop.pdf) --nup 1x5 --landscape --outfile UroCA.pdf
