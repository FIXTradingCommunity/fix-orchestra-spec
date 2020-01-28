#!/bin/bash

echo Compilation started...

pandoc FIXDisclaimerTechStdDRAFT.md "/Users/hanno/FIX Protocol/GitHub/fix-orchestra-spec/v1-0-DRAFT/orchestra_spec.md" -o "FIX Orchestra V1.0 DS with TechStd style.docx" --reference-doc=FIX_TechStd_Style.docx --metadata-file=Orchestra.yaml --toc --toc-depth=4

echo Compilation ended!
