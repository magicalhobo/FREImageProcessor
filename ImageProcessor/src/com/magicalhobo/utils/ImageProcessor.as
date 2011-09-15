package com.magicalhobo.utils
{
	import flash.display.BitmapData;
	import flash.external.ExtensionContext;
	import flash.utils.ByteArray;
	
	public class ImageProcessor
	{
		private var context:ExtensionContext;
		
		public function ImageProcessor()
		{
			context = ExtensionContext.createExtensionContext('com.magicalhobo.utils.ImageProcessor', '');
		}
		
		public function encodeBMP(image:BitmapData):ByteArray
		{
			var bytes:ByteArray = new ByteArray();
			context.call('encodeBMP', image, bytes);
			return bytes;
		}
		
		public function encodeJPEG(image:BitmapData):ByteArray
		{
			var bytes:ByteArray = new ByteArray();
			context.call('encodeJPEG', image, bytes);
			return bytes;
		}
		
		public function encodePNG(image:BitmapData):ByteArray
		{
			var bytes:ByteArray = new ByteArray();
			context.call('encodePNG', image, bytes);
			return bytes;
		}
	}
}