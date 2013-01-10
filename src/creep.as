package  
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Charcoal
	 */
	public class creep extends FlxSprite 
	{
		
		public function creep() 
		{
			super();
			makeGraphic(8, 8, 0xFFFFFFFF);
			kill();
		}
		
		override public function reset(X:Number, Y:Number):void 
		{
			super.reset(X, Y);
			color = FlxG.random() * 0xFFFFFF;
		}
		
		override public function update():void 
		{
			super.update();
			if ((velocity.x > 0 && x > FlxG.width / 2 - PlayState.singleton.alleyWidth / 2 - width) ||
				(velocity.x < 0 && x < FlxG.width / 2 + PlayState.singleton.alleyWidth / 2))
				{
					kill();
					PlayState.singleton.creepHurt();
				}
		}
	}

}