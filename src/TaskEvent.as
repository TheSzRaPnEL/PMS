package
{
	import flash.events.Event;
	
	/**
	 * Task events.
	 * @author SzRaPnEL
	 */
	public class TaskEvent extends Event
	{
		public static const PROGRESS_DONE:String = "taskProgressDone";
		public static const CHECK_DONE:String = "taskCheckDone";
		public static const CHECK_FAIL:String = "taskCheckFail";
		public static const FINISHED:String = "taskFinished";
		static public const PLACED_IN_PROGRESS_COLUMN:String = "placedInProgressColumn";
		public static const PLACED_IN_CHECK_COLUMN:String = "taskPlacedInColumn";
		static public const PLACED_IN_DONE_COLUMN:String = "placedInDoneColumn";
		
		public function TaskEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}