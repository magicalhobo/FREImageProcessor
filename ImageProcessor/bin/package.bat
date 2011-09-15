echo Replace DLL_PATH and SDK_PATH before running
pause

copy "DLL_PATH\FREImageProcessor.dll" .\
"SDK_PATH\bin\adt.bat" -package -storetype pkcs12 -keystore test.p12 -storepass test -target ane ImageProcessor.ane extension.xml -swc ImageProcessor.swc -platform Windows-x86 library.swf FREImageProcessor.dll