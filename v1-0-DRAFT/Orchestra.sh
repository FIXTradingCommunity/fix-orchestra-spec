echo Compilation started...

pandoc FIXDisclaimerTechStdDS.md orchestra_spec.md -o "FIX Orchestra V1.0 Draft Standard.docx" --reference-doc=../FIX_TechStd_Style.docx --metadata-file=Orchestra.yaml --toc --toc-depth=4

echo Compilation ended!
