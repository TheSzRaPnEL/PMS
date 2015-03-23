package 
{
	/**
	 * Common display object inteface.
	 * @author SzRaPnEL
	 */
	public interface IDisplayObject 
	{
		function set width(value:Number):void
		
		function get width():Number
		
		function set height(value:Number):void
		
		function get height():Number
		
		function set x(value:Number):void
		
		function get x():Number
		
		function set y(value:Number):void
		
		function get y():Number
		
		function set visible(value:Boolean):void
		
		function get visible():Boolean
	}
}