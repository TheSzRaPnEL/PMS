package
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	
	/**
	 * Class defining progress bar object.
	 * @author SzRaPnEL
	 */
	public class ProgressBar extends Sprite implements IProgressBar
	{
		private var background:Sprite;
		private var foreground:Sprite;
		private var _percent:int;
		
		/**
		 * Creates instance of progress bar with its elements.
		 */
		public function ProgressBar(width:uint, height:uint)
		{
			background = new Sprite();
			background.graphics.lineStyle(0, 0, 0.5);
			background.graphics.beginFill(0xEEEEEE);
			background.graphics.drawRect(0, 0, width, height);
			background.graphics.endFill();
			addChild(background);
			
			foreground = new Sprite();
			foreground.graphics.beginFill(0xFF0000);
			foreground.graphics.drawRect(0, 0, width, height);
			foreground.graphics.endFill();
			addChild(foreground);
			foreground.visible = false;
			
			_percent = 0;
		}
		
		/**
		 * Sets progress bar size based on percentage given.
		 * Value between <0,100>
		 * @param value:int
		 */
		public function set percent(value:int):void
		{
			_percent = value;
			
			if (value <= 0)
			{
				foreground.visible = false;
			}
			else if (value > 0 && value < 100 && background.width != 0)
			{
				foreground.visible = true;
				foreground.width = value / 100 * background.width;
			}
			else if (value >= 100 && background.width != 0)
			{
				foreground.visible = true;
				foreground.width = background.width;
			}
		}
		
		/**
		 * Sets progress bar size based on percentage given.
		 * Value between <0,100>
		 * @param value:int
		 */
		public function get percent():int
		{
			return _percent;
		}
		
	}
}