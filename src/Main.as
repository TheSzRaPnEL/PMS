package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class Main extends Sprite
	{
		private var tasks:Vector.<Task>;
		private var currTask:Task;
		private var currColumn:Column;
		private var anchor:Point;
		private var columns:Vector.<Column>;
		private var tasksDone:int;
		
		public function Main()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			tasks = new Vector.<Task>;
			columns = new Vector.<Column>;
			var columnsNum:int = 4;
			anchor = new Point();
			tasksDone = 0;
			
			for (var i:int = 0; i < columnsNum; i++)
			{
				var column:Column = new Column(stage.fullScreenWidth / (columnsNum + 1), stage.fullScreenHeight);
				addChild(column);
				column.x = i * column.width * 1.1 + column.width * 0.35;
				column.y = column.width * 0.35;
				columns.push(column);
			}
			
			columns[0].name = ColumnNames.TODO_COLUMN;
			columns[1].name = ColumnNames.PROGRESS_COLUMN;
			columns[2].name = ColumnNames.CHECK_COLUMN;
			columns[3].name = ColumnNames.DONE_COLUMN;
			
			for (i = 0; i < 4; i++)
			{
				var task:Task = new Task(column.width, column.width / 4);
				addChild(task);
				task.y = i * 52;
				task.complexity = 50 + int(200 * Math.random());
				tasks.push(task);
				task.availableColumns = new <String>[ColumnNames.TODO_COLUMN, ColumnNames.PROGRESS_COLUMN];
				task.removeEventListener(TaskEvent.PLACED_IN_PROGRESS_COLUMN, onTaskPlacedInProgressColumn_handler);
				task.addEventListener(TaskEvent.PLACED_IN_PROGRESS_COLUMN, onTaskPlacedInProgressColumn_handler);
				columns[0].addTask(task);
			}
			
			removeEventListener(MouseEvent.MOUSE_DOWN, onTaskMouseDown_handler);
			addEventListener(MouseEvent.MOUSE_DOWN, onTaskMouseDown_handler);
			removeEventListener(MouseEvent.MOUSE_MOVE, onTaskMouseMove_handler);
			addEventListener(MouseEvent.MOUSE_MOVE, onTaskMouseMove_handler);
			removeEventListener(MouseEvent.MOUSE_UP, onTaskMouseUp_handler);
			addEventListener(MouseEvent.MOUSE_UP, onTaskMouseUp_handler);
		}
		
		private function onTaskPlacedInProgressColumn_handler(e:TaskEvent):void 
		{
			var task:Task = Task(e.target);
			task.mouseEnabled = false;
			task.removeEventListener(TaskEvent.PLACED_IN_PROGRESS_COLUMN, onTaskPlacedInProgressColumn_handler);
			task.progressBar.percent = 0;
			task.progress = 0;
			task.progressBar.visible = true;
			task.indicator.visible = false;
			task.removeEventListener(Event.ENTER_FRAME, taskProgress_handler);
			task.addEventListener(Event.ENTER_FRAME, taskProgress_handler);
			task.removeEventListener(TaskEvent.PROGRESS_DONE, onTaskProgressDone_handler);
			task.addEventListener(TaskEvent.PROGRESS_DONE, onTaskProgressDone_handler);
		}
		
		private function onTaskPlacedInCheckColumn_handler(e:TaskEvent):void 
		{
			var task:Task = Task(e.target);
			task.mouseEnabled = false;
			task.removeEventListener(TaskEvent.PLACED_IN_CHECK_COLUMN, onTaskPlacedInCheckColumn_handler);
			task.progressBar.percent = 0;
			task.progress = 0;
			task.progressBar.visible = true;
			task.indicator.visible = false;
			task.removeEventListener(Event.ENTER_FRAME, taskProgress_handler);
			task.addEventListener(Event.ENTER_FRAME, taskProgress_handler);
			task.removeEventListener(TaskEvent.PROGRESS_DONE, onTaskCheckProgressDone_handler);
			task.addEventListener(TaskEvent.PROGRESS_DONE, onTaskCheckProgressDone_handler);
		}
		
		private function taskProgress_handler(e:Event):void 
		{
			var task:Task = Task(e.target);
			
			task.progress++;
			task.progressBar.percent = int(task.progress / task.complexity * 100);
			
			if (task.progressBar.percent >= 100)
			{
				task.removeEventListener(Event.ENTER_FRAME, taskProgress_handler);
				task.dispatchEvent(new TaskEvent(TaskEvent.PROGRESS_DONE));
			}
		}
		
		private function onTaskProgressDone_handler(e:TaskEvent):void 
		{
			var task:Task = Task(e.target);
			task.mouseEnabled = true;
			task.availableColumns = new <String>[ColumnNames.CHECK_COLUMN];
			task.removeEventListener(TaskEvent.PROGRESS_DONE, onTaskProgressDone_handler);
			task.removeEventListener(TaskEvent.PLACED_IN_PROGRESS_COLUMN, onTaskPlacedInProgressColumn_handler);
			task.removeEventListener(TaskEvent.PLACED_IN_CHECK_COLUMN, onTaskPlacedInCheckColumn_handler);
			task.addEventListener(TaskEvent.PLACED_IN_CHECK_COLUMN, onTaskPlacedInCheckColumn_handler);
		}
		
		private function onTaskCheckProgressDone_handler(e:TaskEvent):void 
		{
			var task:Task = Task(e.target);
			task.mouseEnabled = true;
			var random:int = int(2 * Math.random());
			if (random)
			{
				task.indicator.setSign(IndicatorSigns.GOOD_SIGN);
				task.availableColumns = new <String>[ColumnNames.DONE_COLUMN];
				task.removeEventListener(TaskEvent.PLACED_IN_DONE_COLUMN, onTaskPlacedInDoneColumn_handler);
				task.addEventListener(TaskEvent.PLACED_IN_DONE_COLUMN, onTaskPlacedInDoneColumn_handler);
			}
			else
			{
				task.indicator.setSign(IndicatorSigns.BAD_SIGN);
				task.availableColumns = new <String>[ColumnNames.TODO_COLUMN, ColumnNames.PROGRESS_COLUMN];
				task.removeEventListener(TaskEvent.PLACED_IN_PROGRESS_COLUMN, onTaskPlacedInProgressColumn_handler);
				task.addEventListener(TaskEvent.PLACED_IN_PROGRESS_COLUMN, onTaskPlacedInProgressColumn_handler);
			}
			task.indicator.visible = true;
			task.removeEventListener(TaskEvent.PROGRESS_DONE, onTaskCheckProgressDone_handler);
		}
		
		private function onTaskPlacedInDoneColumn_handler(e:TaskEvent):void 
		{
			var task:Task = Task(e.target);
			task.mouseEnabled = false;
			task.indicator.visible = false;
			task.progressBar.visible = false;
			task.deactivate();
			task.availableColumns = new <String>[];
			task.removeEventListener(TaskEvent.PLACED_IN_DONE_COLUMN, onTaskPlacedInDoneColumn_handler);
			
			tasksDone++;
			if (tasksDone >= tasks.length)
			{
				trace("GAME OVER");
			}
		}
		
		private function onTaskMouseDown_handler(me:MouseEvent):void
		{
			if (tasks.indexOf(me.target) != -1)
			{
				currTask = Task(me.target);
				currTask.parent.setChildIndex(currTask, currTask.parent.numChildren - 1);
				anchor.x = me.target.x - me.stageX;
				anchor.y = me.target.y - me.stageY;
				
				for each (var column:Column in columns)
				{
					if (column.hasTask(currTask))
					{
						column.removeTask(currTask);
						currColumn = column;
						break;
					}
				}
			}
		}
		
		private function onTaskMouseMove_handler(me:MouseEvent):void
		{
			if (currTask)
			{
				currTask.x = me.stageX + anchor.x;
				currTask.y = me.stageY + anchor.y;
				
				for each (var column:Column in columns)
				{
					if (currTask.x > column.x - 80 && currTask.x < column.x + 80)
					{
						if (currTask.availableColumns.indexOf(column.name) != -1)
						{
							column.hightlightGood();
						}
						else
						{
							column.hightlightBad();
						}
					}
					else
					{
						column.unhightlight();
					}
				}
			}
		}
		
		private function onTaskMouseUp_handler(me:MouseEvent):void
		{
			if (currTask)
			{
				for each (var column:Column in columns)
				{
					if (currTask.x > column.x - 80 && currTask.x < column.x + 80 && currTask.availableColumns.indexOf(column.name) != -1)
					{
						column.addTask(currTask);
						column.unhightlight();
						if (column != currColumn && columns.indexOf(column) == 1)
						{
							currTask.dispatchEvent(new TaskEvent(TaskEvent.PLACED_IN_PROGRESS_COLUMN));
						}
						else if (column != currColumn && columns.indexOf(column) == 2)
						{
							currTask.dispatchEvent(new TaskEvent(TaskEvent.PLACED_IN_CHECK_COLUMN));
						}
						else if (column != currColumn && columns.indexOf(column) == 3)
						{
							currTask.dispatchEvent(new TaskEvent(TaskEvent.PLACED_IN_DONE_COLUMN));
						}
						currTask = null;
						return;
					}
					else
					{
						column.unhightlight();
					}
				}
				currColumn.addTask(currTask);
				currTask = null;
			}
		}
		
		private function deactivate(e:Event):void
		{
			// make sure the app behaves well (or exits) when in background
			//NativeApplication.nativeApplication.exit();
		}
		
	}
}