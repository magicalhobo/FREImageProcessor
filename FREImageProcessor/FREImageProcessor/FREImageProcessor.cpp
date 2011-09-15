#include <string>

#include "FREImageProcessor.h"

using namespace System;
using namespace System::Drawing;
using namespace System::Drawing::Imaging;
using namespace System::IO;
using namespace System::Runtime::InteropServices;

extern "C"
{
	FREObject encodeImage(uint32_t argc, FREObject argv[], ImageFormat^ format)
	{
		FREObject objectBitmapData = argv[0];
		FREBitmapData bitmapData;

		FREAcquireBitmapData(objectBitmapData, &bitmapData);

		int width = bitmapData.width;
		int height = bitmapData.height;
		int stride = bitmapData.lineStride32 * 4;
		uint32_t* input = bitmapData.bits32;

		FREReleaseBitmapData(objectBitmapData);

		Bitmap^ bitmap = gcnew Bitmap(width, height, stride, PixelFormat::Format32bppArgb, IntPtr(input));
		bitmap->RotateFlip(RotateFlipType::RotateNoneFlipY);

		MemoryStream^ stream = gcnew MemoryStream();

		bitmap->Save(stream, format);

		array<Byte>^ raw = stream->ToArray();

		uint8_t* output = new uint8_t[width * height * 4];

		int outputSize = (int) stream->Length;

		Marshal::Copy(raw, 0, (IntPtr) output, outputSize);

		FREObject objectByteArray = argv[1];
		FREByteArray byteArray;

		FREObject length;
		
		FRENewObjectFromUint32(outputSize, &length);

		FRESetObjectProperty(objectByteArray, (const uint8_t*) "length", length, NULL);

		FREAcquireByteArray(objectByteArray, &byteArray);

		memcpy(byteArray.bytes, output, outputSize);

		FREReleaseByteArray(objectByteArray);

		stream->Close();

		return NULL;
	}

	FREObject encodeBMP(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		return encodeImage(argc, argv, ImageFormat::Bmp);
	}

	FREObject encodeJPEG(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		return encodeImage(argc, argv, ImageFormat::Jpeg);
	}

	FREObject encodePNG(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		return encodeImage(argc, argv, ImageFormat::Png);
	}

	void contextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctions, const FRENamedFunction** functions)
	{
		*numFunctions = 3;

		FRENamedFunction* func = (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * (*numFunctions));

		func[0].name = (const uint8_t*) "encodeBMP";
		func[0].functionData = NULL;
		func[0].function = &encodeBMP;

		func[1].name = (const uint8_t*) "encodeJPEG";
		func[1].functionData = NULL;
		func[1].function = &encodeJPEG;

		func[2].name = (const uint8_t*) "encodePNG";
		func[2].functionData = NULL;
		func[2].function = &encodePNG;

		*functions = func;
	}

	void contextFinalizer(FREContext ctx)
	{
		return;
	}

	void initializer(void** extData, FREContextInitializer* ctxInitializer, FREContextFinalizer* ctxFinalizer)
	{
		*ctxInitializer = &contextInitializer;
		*ctxFinalizer = &contextFinalizer;
	}

	void finalizer(void* extData)
	{
		return;
	}
}
