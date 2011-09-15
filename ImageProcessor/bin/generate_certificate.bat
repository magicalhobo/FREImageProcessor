echo Replace SDK_PATH before running
pause


"SDK_PATH\bin\adt.bat" -certificate -cn SelfSign -ou QE -o "Example, Co" -c US 2048-RSA test.p12 test