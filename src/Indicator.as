package 
{
	import flash.display.Sprite;
	/**
	 * Definition of indicator object.
	 * @author SzRaPnEL
	 */
	public class Indicator extends Sprite implements IIndicator
	{
		private var goodSign:Sprite;
		private var badSign:Sprite;
		
		public function Indicator(width:uint)
		{
			goodSign = new Sprite();
			goodSign.graphics.beginFill(0x00FF00);
			goodSign.graphics.drawCircle(width / 2, width / 2, width / 2);
			goodSign.graphics.endFill();
			addChild(goodSign);
			goodSign.visible = false;
			
			badSign = new Sprite();
			badSign.graphics.beginFill(0xFF0000);
			badSign.graphics.drawRect(0, 0, width, width);
			badSign.graphics.endFill();
			addChild(badSign);
			badSign.visible = false;
		}
		
		public function setSign(signID:String):void
		{
			hideAllSigns();
			
			if (signID == IndicatorSigns.BAD_SIGN)
			{
				badSign.visible = true;
			}
			else if (signID == IndicatorSigns.GOOD_SIGN)
			{
				goodSign.visible = true;
			}
		}
		
		private function hideAllSigns():void
		{
			badSign.visible = false;
			goodSign.visible = false;
		}
		
	}
}