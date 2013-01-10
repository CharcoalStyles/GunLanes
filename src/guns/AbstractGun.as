package guns 
{
	import org.flixel.*;
	
	public class AbstractGun extends FlxSprite
	{
		public var bulletsPerShot:int;
		public var bulletsLevel:int;
		public var spread:Number;
		public var spreadLevel:int;
		public var speed:Number;
		public var speedLevel:int
		public var rate:Number;
		public var rateLevel:int;
		
		public var movespeed:Number;
		public var moveSpeedLevel:int;
		private var currentMoveSpeed:Number;
		
		protected var pointingRight:Boolean;
		
		private var timer:Number;
		
		public var firing:Boolean;
		
		public function AbstractGun(X:int, width:int, right:Boolean) 
		{
			super(X, FlxG.height / 2);
			makeGraphic(width, width, 0xFF404040);
			
			pointingRight = right;
			timer = 0;
			
			
			firing = false;
		}
		override public function reset(X:Number, Y:Number):void 
		{
			super.reset(x, FlxG.height / 2);
			bulletsPerShot = 1;
			spread = 5;
			speed = 50;
			rate = 0.7;
			movespeed = 100;
			currentMoveSpeed = 0;
			
			bulletsLevel = 1;
			spreadLevel = 1;
			speedLevel = 1;
			rateLevel = 1;
			moveSpeedLevel = 1;
		}
		
		override public function update():void
		{
			timer += FlxG.elapsed;
			
			if (timer >= rate && firing)
			{
				timer = 0;
				
				for (var i:int = 0; i < bulletsPerShot; i++)
				{
					var b:bullet = PlayState.singleton.bullets.getFirstDead() as bullet;
					b.reset(x + width / 2, y + height / 2);
					b.velocity = new FlxPoint((pointingRight ? 1:-1) * speed, (FlxG.random() * 2 - 1) * spread);
				}
			}
			
			for (var i:int = 0; i < PlayState.touchPoints.length; i++)
			{
				if (PlayState.touchPoints[i] != null)
				{
					var point:FlxPoint = PlayState.touchPoints[i];
					if ((point.x > FlxG.width / 2) == pointingRight)
					{
						if (point.y > y)
							currentMoveSpeed += FlxG.elapsed * movespeed;
						else
							currentMoveSpeed -= FlxG.elapsed * movespeed;
					}
				}
			}
			
			currentMoveSpeed *= 0.98;
			
			velocity.y = currentMoveSpeed;
			if (y <= PlayState.singleton.laneHeight * 1.25){
				//velocity.y *= -0.75;
				y = PlayState.singleton.laneHeight * 1.25;
			}
			if (y > FlxG.height - height) {
				//velocity.y *= -0.75
				y = FlxG.height - height;
			}
			
			super.update();
		}
	}

}