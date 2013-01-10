package  
{
	import guns.AbstractGun;
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Charcoal
	 */
	public class PlayState extends FlxState 
	{
		public static var singleton:PlayState;
		
		public var laneHeight:int;
		public var bullets:FlxGroup;
		public var creeps:FlxGroup;
		
		public static var touchPoints:Array;
		
		public const lanes:int = 8;
		public const alleyWidth:int = 20;
		
		public var leftGun:AbstractGun;
		public var rightGun:AbstractGun;
		
		public var wave:int;
		public var waveText:FlxText;
		public var health:int;
		public var maxHealth:int;
		public var healthText:FlxText;
		public var money:int;
		public var moneyText:FlxText;
		
		public var messageText:FlxText;
		public var miniMessageText:FlxText;
		
		public var roundStock:int;
		
		public var mode:int;
		public var modeTimer:Number;
		
		private var buyUI:BuyUI;
		
		private var hitsThisWave:int;
		
		public function PlayState() 
		{
			super();
			singleton = this;
			
			laneHeight = FlxG.height / (lanes + 1);
			
			var i:int;
			
			for (i = 1; i < lanes +1; i++)
			{
				var block:FlxSprite = new FlxSprite(0, i * laneHeight);
				var u:uint = 0x40000000 + (Math.random() * 0xFFFFFF);
				block.makeGraphic(FlxG.width / 2 - alleyWidth / 2, laneHeight, u);
				add(block);
				block = new FlxSprite(FlxG.width/2 + alleyWidth/2, i * laneHeight);
				u = 0x40000000 + (Math.random() * 0xFFFFFF);
				block.makeGraphic(FlxG.width / 2 - alleyWidth / 2, laneHeight, u);
				add(block);
			}
			var block:FlxSprite = new FlxSprite(FlxG.width / 2 - alleyWidth / 2, i * laneHeight);
			var u:uint = 0x8FFFFFF;
			block.makeGraphic(alleyWidth / 2, FlxG.height, u);
			add(block);
			
			bullets = new FlxGroup();
			for (i = 0; i < 300; i++)
			{
				var b:bullet = new bullet();
				bullets.add(b);
			}
			add(bullets);
			
			creeps = new FlxGroup();
			for (i = 0; i < 100; i++)
			{
				var c:creep = new creep();
				creeps.add(c);
			}
			add(creeps);
			
			leftGun = new AbstractGun(FlxG.width / 2 - alleyWidth / 2 + 2, 6, false);
			leftGun.reset(0,0)
			add(leftGun);
			rightGun = new AbstractGun(FlxG.width / 2 + alleyWidth / 2 - 8, 6, true);
			rightGun.reset(0,0);
			add(rightGun);
			
			wave = 0;
			waveText = new FlxText(0, 0, FlxG.width, "Wave: 0\nRem:100");
			waveText.setFormat(null, 16, 0xFFFFFFF, "left", 0x404040);
			add(waveText);
			health = 10;
			maxHealth = 10;
			healthText = new FlxText(0, 0, FlxG.width, health + "/" + maxHealth);
			healthText.setFormat(null, 16, 0xFFFFFFF, "center", 0x404040);
			add(healthText);
			money = 0;
			moneyText = new FlxText(0, 0, FlxG.width, "$0");
			moneyText.setFormat(null, 16, 0xFFFFFFF, "right", 0x404040);
			add(moneyText);
			
			messageText = new FlxText(0, FlxG.height / 2.3, FlxG.width);
			messageText.setFormat(null, 32, 0xFFFFFFF, "center", 0x404040);
			add(messageText);
			miniMessageText = new FlxText(0, FlxG.height / 2, FlxG.width);
			miniMessageText.setFormat(null, 16, 0xFFFFFF, "center", 0x404040);
			add(miniMessageText);
			
			buyUI = new BuyUI();
			buyUI.visible = false;
			add(buyUI);
			
			mode = 0;
			modeTimer = 0;
		}
		
		override public function update():void 
		{
			
			switch (mode)
			{
				case 0://pre round
					if (modeTimer == 0)
					{
						wave++;
						roundStock = 10 + wave * 10;
						//roundStock = 1;
						messageText.text = "Tap to play";
						
						waveText.text = "Wave: " + wave.toString() + "\nStock: " + roundStock.toString();
						leftGun.firing = false;
						rightGun.firing = false;
						hitsThisWave = 0;
						
						if (wave > 1)
						{
							var interest:int = money * 0.1;
							miniMessageText.text = "Interest: $" + interest.toString();
							money += interest;
							moneyText.text = "$" + money.toString();
						}
					}
					
					modeTimer += FlxG.elapsed;
					
					if (FlxG.mouse.justPressed())
					{
						messageText.text = "";
						miniMessageText.text = "";
						mode++;
						modeTimer = 0;
						
						newSpawn();
						waveText.text = "Wave: " + wave.toString() + "\nStock: " + roundStock.toString();
						leftGun.firing = true;
						rightGun.firing = true;
					}
					break;
				case 1://play
					modeTimer += FlxG.elapsed;
					
					if (modeTimer >= 10 - (wave * 0.02) || creeps.countLiving() == 0)
					{
						modeTimer = 0;
						newSpawn();
						waveText.text = "Wave: " + wave.toString() + "\nStock: " + roundStock.toString();
						
						if (roundStock <= 0)
							mode++;
					}
					break;
				case 2://runout
					if (creeps.countLiving() == 0)
					{
						mode++;
						modeTimer = 0;
						leftGun.firing = false;
						rightGun.firing = false;
					}
					break;
				case 3://upgrade
					if (modeTimer == 0)
					{
						messageText.text = "Wave Over!";
						
						if (hitsThisWave == 0)
						{
							miniMessageText.text += "Perfect wave +$20\n";
							money += 20;
						}
						if (hitsThisWave >= 7)
						{
							miniMessageText.text += "Slaughter +$15\n";
							money += 15;
						}
						
						moneyText.text = "$" + money.toString();
					}
					
					modeTimer += FlxG.elapsed;
					
					if (modeTimer >= 5)
					{
						mode++;
						modeTimer = 0;
						miniMessageText.text = "";
					}
					break;
				case 4://buy
					if (modeTimer == 0)
					{
						buyUI.visible = true;
						buyUI.set();
					}
					modeTimer += FlxG.elapsed;
					break;
				case 5://Game Over
					if (modeTimer == 0)
					{
						leftGun.firing = false;
						rightGun.firing = false;
						
						messageText.text = "Game Over";
					}
					modeTimer += FlxG.elapsed;
					break;
			}
			super.update();
			
			FlxG.overlap(bullets, creeps, bulletoncreep);
			
		}
		
		public function upBullets():void
		{
			//rereer
		}
		
		private function bulletoncreep(obj1:FlxObject, obj2:FlxObject):void
		{			
			obj1.kill();
			obj2.kill();
			money++;
			moneyText.text = "$" + money.toString();
		}
		
		public function creepHurt():void
		{
			health--;
			hitsThisWave++;
			
			healthText.text = health + "/" + maxHealth;
			
			if (health == 0)
			{
				mode = 5;
				modeTimer = 0;
				
				while (creeps.countLiving() > 0)
				{
					creeps.getFirstAlive().kill();
				}
			}
		}
		
		private function newSpawn():void
		{
			for (var i:int = 0; i < (wave / 5); i++)
			{
				var lane:int = lanes * FlxG.random();
				var right:Boolean = FlxG.random() > 0.5;
				for (var o:int = 0; o < wave / 10 + Math.floor((wave % 10) / 2) + 1; o ++)
				{
					if (roundStock > 0)
					{
						var c:creep = creeps.getFirstDead() as creep;
						var xPos:int = right ? FlxG.width : -c.width;
						xPos += (right ? 1: -1) * 10 * o;
						var yPos:int = (lane + 1) * laneHeight + (laneHeight / 2) +
							(FlxG.random() * 2 - 1) * (laneHeight / 4);
						c.reset(xPos,  yPos);
						c.velocity.x = (right ? -1 :1) * (wave / 10 + 3) * (FlxG.width / 250);
						
						roundStock--;
					}
				}
			}
		}
	}

}