package 
{
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class Column extends Sprite
	{
		private var tasks:Vector.<Task>
		private var goodGlowFilter:Array;
		private var badGlowFilter:Array;
		private var shadowFilter:Array;
		
		public function Column(width:uint, height:uint)
		{
			tasks = new Vector.<Task>;
			
			graphics.beginFill(0xEEEEEE);
			graphics.drawRect(0, 0, width, height);
			graphics.endFill();
			shadowFilter = [new DropShadowFilter(2, 90)];
			goodGlowFilter = [new GlowFilter(0x00FF00)];
			badGlowFilter = [new GlowFilter(0xFF0000)];
		}
		
		public function addTask(task:Task):void
		{
			task.x = x;
			task.y = y + currTasksHeight();
			tasks.push(task);
		}
		
		private function taskHeapHeight(index:int):Number 
		{
			if (index > tasks.length) index = tasks.length;
			var sumHeight:Number = 0;
			for (var i:int = 0; i < index; i++)
			{
				sumHeight += tasks[i].height;
			}
			return sumHeight;
		}
		
		private function currTasksHeight():Number 
		{
			return taskHeapHeight(tasks.length);
		}
		
		public function removeTask(task:Task):void
		{
			tasks.splice(tasks.indexOf(task), 1);
			updateTasksPos();
		}
		
		private function updateTasksPos():void 
		{
			for (var i:int = 0; i < tasks.length; i++)
			{
				var task:Task = tasks[i];
				task.x = x;
				task.y = y + taskHeapHeight(i);
			}
		}
		
		public function hasTask(task:Task):Boolean
		{
			return tasks.indexOf(task) + 1;
		}
		
		public function hightlightGood():void
		{
			filters = goodGlowFilter;
		}
		
		public function hightlightBad():void
		{
			filters = badGlowFilter;
		}
		
		public function unhightlight():void
		{
			filters = shadowFilter;
		}
		
	}

}