package
{
	import com.magicalhobo.utils.ImageProcessor;
	
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	
	public class ImageProcessorTest extends Sprite
	{
		private var textField:TextField;

		private var loader:Loader;
		
		public function ImageProcessorTest()
		{
			textField = new TextField();
			textField.wordWrap = true;
			textField.width = stage.stageWidth/2;
			textField.height = stage.stageHeight;
			addChild(textField);
			
			loader = new Loader();
			loader.x = stage.stageWidth/2;
			addChild(loader);
			
			stage.addEventListener(MouseEvent.CLICK, clickHandler);
			
			log('Click to capture stage contents');
		}
		
		private function log(message:String):void
		{
			textField.appendText(message+'\n');
		}
		
		private function save(bytes:ByteArray, path:String):void
		{
			var fileStream:FileStream = new FileStream();
			fileStream.open(new File(path), FileMode.WRITE);
			fileStream.writeBytes(bytes);
			fileStream.close();
		}
		
		private function show(bytes:ByteArray):void
		{
			loader.loadBytes(bytes);
		}

		protected function clickHandler(event:MouseEvent):void
		{
			try
			{
				var p:ImageProcessor = new ImageProcessor();
				log('Extension created successfully');
				try
				{
					var snapshot:BitmapData = new BitmapData(stage.stageWidth, stage.stageHeight);
					snapshot.draw(stage);
					
					var start:uint = getTimer();
					var bytes:ByteArray = p.encodeJPEG(snapshot);
					log('Encoded to JPEG of '+bytes.length+' bytes in '+(getTimer() - start)+'ms');
					
					show(bytes);
				}
				catch(e:*)
				{
					log('Error encoding: '+e);
				}
			}
			catch(e:*)
			{
				log('Error creating extension: '+e);
			}
		}
	}
}