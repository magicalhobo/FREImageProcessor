FREImageProcessor
=================

An AIR 3 Windows-x86 .NET Native Extension for encoding images. The extension uses .NET to transcode `BitmapData` objects into .bmp, .jpg, and .png formats much faster than existing ActionScript or Alchemy methods.

Contents:

- `FREImageProcessor` - A Visual C++ 2010 Express project which contains the native code.
- `ImageProcessor` - A Flash Builder Library project for exposing an API to the native code in ActionScript.
- `ImageProcessorTest` - A sample Flash Builder project which uses the extension to encode an image.
- Batch files, so you don't have to use the command line.
- All intermediate files, so you don't have to compile everything yourself.

Requirements:

- Visual C++ 2010 Express
- AIR 3 SDK from Adobe Labs
- Flash Builder 4

The project contains some placeholder files that I cannot include in the repository because they are copyrighted by Adobe. After checking out the project, you need to:

- Replace `FREImageProcessor/FREImageProcessor/FlashRuntimeExtensions.h` with `AIR_SDK/include/FlashRuntimeExtensions.h`
- Replace `FREImageProcessor/FREImageProcessor/FlashRuntimeExtensions.lib` with `AIR_SDK/lib/win/FlashRuntimeExtensions.lib`

Now that everything is setup, you can try compiling everything yourself.

1. Open `FREImageProcessor/FREImageProcessor.sln` in Visual C++ 2010
1. Build the .dll (F7)
1. Import `ImageProcessor` into Flash Builder
1. Build the .swc (Ctrl + B)
1. Open the .swc with a .zip editor, and extract library.swf to the same folder as the .swc
1. Build the .ane (run `ImageProcessor/bin/package.bat`)
1. Import `ImageProcessorTest` into Flash Builder
1. Build the .swf (Ctrl + B)
1. Build the .exe (run `ImageProcessorTest/bin-debug/package.bat`)
1. If everything was successful, you can run the .exe and click the stage to encode a JPEG. It will be saved to `C:\temp.jpg`.
