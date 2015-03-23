package
{
	/**
	 * Interface for ProgressBar objects.
	 * @author SzRaPnEL
	 */
	public interface IProgressBar extends IDisplayObject
	{
		function set percent(value:int):void
		
		function get percent():int
	}
}