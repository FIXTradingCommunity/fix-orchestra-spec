echo Compilation started...

pandoc FIXDisclaimerTechStd.md orchestra_spec.md -o "FIX Orchestra V1.0 Draft Standard.docx" --reference-doc=../FIX_TechStd_Style_MASTER.docx --metadata-file=Orchestra.yaml --toc --toc-depth=4
pandoc orchestra_spec.md -o OrchestraONLINE.html

# Create separate online versions for production and test website by including appropriate link prefixes
sed s/'img src="media\/'/'img src="https:\/\/www.fixtrading.org\/wp-content\/uploads\/2020\/02\/'/ OrchestraONLINE.html > OrchestraONLINE_PROD.html
sed s/'img src="media\/'/'img src="https:\/\/www.technical-fixprotocol.org\/wp-content\/uploads\/2020\/02\/'/ OrchestraONLINE.html > OrchestraONLINE_TEST.html
# Change remaining links to production website in test version to test website
sed -i '.bak' s/www.fixtrading.org/www.technical-fixprotocol.org/ OrchestraONLINE_TEST.html
echo Orchestra ONLINE version created for PROD and TEST

echo Compilation ended!
