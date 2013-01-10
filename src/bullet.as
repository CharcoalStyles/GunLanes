package  
{
	import org.flixel.*;
	
	public class bullet extends FlxSprite
	{
		
		public function bullet() 
		{
			super();
			makeGraphic(2, 2, 0xFFa0a0a0);
			kill();
		}
		
		override public function update():void 
		{
			super.update();
			
			if (x < -width ||
				x > FlxG.width)
				kill();
		}
	}

}