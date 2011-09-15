echo Replace SDK_PATH and ANE_PATH before running
pause

"SDK_PATH\bin\adt.bat" -package -XnoAneValidate -storetype pkcs12 -keystore test.p12 -storepass test -target native ImageProcessorTest ImageProcessorTest-app.xml ImageProcessorTest.swf -extdir "ANE_PATH"