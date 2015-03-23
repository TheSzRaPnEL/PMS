package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * Task object definition.
	 * @author SzRaPnEL
	 */
	public class Task extends Sprite
	{
		private var nameLabel:TextField;
		private var _progressBar:IProgressBar;
		private var _indicator:IIndicator;
		private var _availableColumns:Vector.<String>;
		private var _complexity:int;
		private var _progress:int;
		
		public function Task(width:uint, height:uint)
		{
			graphics.lineStyle(1);
			graphics.beginFill(0xFFFFFF);
			graphics.drawRect(0, 0, width, height);
			graphics.endFill();
			filters = [new DropShadowFilter(2, 90, 0, 0.5)];
			
			nameLabel = new TextField();
			nameLabel.autoSize = TextFieldAutoSize.LEFT;
			nameLabel.width = width;
			nameLabel.height = height * 0.2;
			nameLabel.text = "Task";
			nameLabel.mouseEnabled = false;
			addChild(nameLabel);
			
			_progressBar = new ProgressBar(width * 0.8, width * 0.05);
			_progressBar.percent = 0;
			_progressBar.x = width * 0.1;
			_progressBar.y = height - width * 0.1;
			_progressBar.visible = false;
			addChild(DisplayObject(_progressBar));
			
			_indicator = new Indicator(width * 0.05);
			_indicator.setSign(IndicatorSigns.BAD_SIGN);
			_indicator.x = width * 0.925;
			_indicator.y = width * 0.025;
			_indicator.visible = false;
			addChild(DisplayObject(_indicator));
			
			_availableColumns = new Vector.<String>;
			mouseChildren = false;
		}
		
		public function get progressBar():IProgressBar 
		{
			return _progressBar;
		}
		
		public function get indicator():IIndicator 
		{
			return _indicator;
		}
		
		public function get availableColumns():Vector.<String> 
		{
			return _availableColumns;
		}
		
		public function set availableColumns(value:Vector.<String>):void 
		{
			_availableColumns = value;
		}
		
		public function get complexity():int 
		{
			return _complexity;
		}
		
		public function set complexity(value:int):void 
		{
			_complexity = value;
		}
		
		public function get progress():int 
		{
			return _progress;
		}
		
		public function set progress(value:int):void 
		{
			_progress = value;
		}
		
		public function deactivate():void
		{
			alpha = 0.3;
		}
		
	}
}