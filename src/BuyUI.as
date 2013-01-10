package  
{
	import org.flixel.*;
	
	public class BuyUI extends FlxGroup
	{
		//col 1, row 1
		private var buyBulletsTxt:FlxText;
		private var buyBulletsBut:FlxButton;
		
		//col 2, row 1
		private var buySpreadTxt:FlxText;
		private var buySpreadBut:FlxButton;
		
		//col 1, row 2
		private var buyBulSpeedTxt:FlxText;
		private var buyBulSpeedBut:FlxButton;
		
		//col 2, row 2
		private var buyRateTxt:FlxText;
		private var buyRateBut:FlxButton;
		
		//col 1, row 3
		private var buyMovSpeedTxt:FlxText;
		private var buyMovSpeedBut:FlxButton;
		
		//col 1, row 4
		private var buyHealthTxt:FlxText;
		private var buyHealthBut:FlxButton;
		
		//col 2, row 4
		private var buyMaxHealthTxt:FlxText;
		private var buyMaxHealthBut:FlxButton;
		
		private var ExitBut:FlxButton;
		
		public function BuyUI() 
		{
			super();
			
			var fader:FlxSprite = new FlxSprite();
			fader.makeGraphic(FlxG.width, FlxG.height, 0x80000000);
			add(fader);
			
			var column1TxtX:int = 10;
			var column1ButX:int = FlxG.width / 2 - 80;
			
			var column2TxtX:int = FlxG.width / 2 + 10;
			var column2ButX:int = FlxG.width - 90;
			
			var rowCulmin:int = 50;
			
			buyBulletsTxt = new FlxText(column1TxtX, rowCulmin, FlxG.width / 2, "More Bullets per shot");
			buyBulletsTxt.setFormat(null, 16, 0xFFFFFF, "left");
			add(buyBulletsTxt);
			
			buyBulletsBut = new FlxButton(column1ButX, rowCulmin, "$100", buyBullets);
			add(buyBulletsBut);
			
		//col 2, row 1
			buySpreadTxt = new FlxText(column2TxtX, rowCulmin, FlxG.width / 2, "Bullets fly straighter");
			buySpreadTxt.setFormat(null, 16, 0xFFFFFF, "left");
			add(buySpreadTxt);
			
			buySpreadBut = new FlxButton(column2ButX, rowCulmin, "$100", buySpread);
			add(buySpreadBut);
			
			rowCulmin += 24;
			
		//col 1, row 2
			buyBulSpeedTxt = new FlxText(column1TxtX, rowCulmin, FlxG.width / 2, "Bullets fly faster");
			buyBulSpeedTxt.setFormat(null, 16, 0xFFFFFF, "left");
			add(buyBulSpeedTxt);
			buyBulSpeedBut = new FlxButton(column1ButX, rowCulmin, "$100", buyBulSpeed);
			add(buyBulSpeedBut);
		
		//col 2, row 2
			buyRateTxt = new FlxText(column2TxtX, rowCulmin, FlxG.width / 2, "Bullets fire faster");
			buyRateTxt.setFormat(null, 16, 0xFFFFFF, "left");
			add(buyRateTxt);
			buyRateBut = new FlxButton(column2ButX, rowCulmin, "$100", buyRate);
			add(buyRateBut);
		
			rowCulmin += 24;
			
		//col 1, row 3
			buyMovSpeedTxt = new FlxText(column1TxtX, rowCulmin, FlxG.width / 2, "Shooters move faster");
			buyMovSpeedTxt.setFormat(null, 16, 0xFFFFFF, "left");
			add(buyMovSpeedTxt);
			buyMovSpeedBut = new FlxButton(column1ButX, rowCulmin, "$100", buyMovSpeed);
			add(buyMovSpeedBut);
			
			rowCulmin += 24;
			
		//col 1, row 4
			buyHealthTxt = new FlxText(column1TxtX, rowCulmin, FlxG.width / 2, "Recover health");
			buyHealthTxt.setFormat(null, 16, 0xFFFFFF, "left");
			add(buyHealthTxt);
			buyHealthBut = new FlxButton(column1ButX, rowCulmin, "$100", buyHealth);
			add(buyHealthBut);
		
		//col 2, row 4
			buyMaxHealthTxt = new FlxText(column2TxtX, rowCulmin, FlxG.width / 2, "Add maximum health");
			buyMaxHealthTxt.setFormat(null, 16, 0xFFFFFF, "left");
			add(buyMaxHealthTxt);
			buyMaxHealthBut = new FlxButton(column2ButX, rowCulmin, "$100", buyMaxHealth);
			add(buyMaxHealthBut);
			
			ExitBut = new FlxButton(FlxG.width / 2 - 40, FlxG.height - 20, "Done", onDone);
			add(ExitBut);
		}
		
		public function set():void
		{
			
		//col 1, row 1
		buyBulletsTxt.text = "More bullets per shot (" + PlayState.singleton.rightGun.bulletsLevel + " + 1)";
		buyBulletsBut.label.text = "$" + (50 + 100 * PlayState.singleton.rightGun.bulletsLevel);
		
		//col 2, row 1
		buySpreadTxt.text = "More accurate bullets (" + PlayState.singleton.rightGun.spread.toPrecision(3) + " * 0.9)";
		buySpreadBut.label.text = "$" + Math.floor(15 + 25 * PlayState.singleton.rightGun.spreadLevel * 0.8);
		
		//col 1, row 2
		buyBulSpeedTxt.text = "Faster moving bullets (" + PlayState.singleton.rightGun.speed + " + 10)";
		buyBulSpeedBut.label.text = "$" + (10 + 30 * PlayState.singleton.rightGun.speedLevel);
		
		//col 2, row 2
		buyRateTxt.text = "Faster firing bullets (" + PlayState.singleton.rightGun.rate.toPrecision(3)+ " * 0.9)";;
		buyRateBut.label.text = "$" + Math.floor(40 + 25 * PlayState.singleton.rightGun.rateLevel * 0.85);
		
		//col 1, row 3
		buyMovSpeedTxt.text = "Gun moves faster (" + PlayState.singleton.rightGun.movespeed + " + 20)";;
		buyMovSpeedBut.label.text = "$" + Math.floor(50 + 25 * PlayState.singleton.rightGun.moveSpeedLevel * 1.2);
		
		//col 1, row 4
		buyHealthTxt.text = "Recover health (" + PlayState.singleton.health + " + 1)";
		buyHealthBut.label.text = "$15";
		
		//col 2, row 4
		buyMaxHealthTxt.text = "Add maximum health (" + PlayState.singleton.maxHealth + " + 1)";
		buyMaxHealthBut.label.text = "$" + (140 + (PlayState.singleton.maxHealth - 9) * 10);
		
		PlayState.singleton.moneyText.text = "$" + PlayState.singleton.money.toString();
		PlayState.singleton.healthText.text = PlayState .singleton.health + "/" + PlayState .singleton.maxHealth;
		}
		
		public function onDone():void
		{
			if (visible)
			{
				visible = false;
				PlayState.singleton.mode = 0;
				PlayState.singleton.modeTimer = 0;
			}
		}
		
		public function buyBullets():void
		{
			if (visible && PlayState.singleton.money >= (50 + 100 * PlayState.singleton.rightGun.bulletsLevel))
			{
				PlayState.singleton.money -=  (50 + 100 * PlayState.singleton.rightGun.bulletsLevel);
				PlayState.singleton.rightGun.bulletsLevel++;
				PlayState.singleton.leftGun.bulletsLevel++;
				PlayState.singleton.rightGun.bulletsPerShot++;
				PlayState.singleton.leftGun.bulletsPerShot++;
				set();
			}
		}
		
		public function buySpread():void
		{
			if (visible && PlayState.singleton.money >= Math.floor(15 + 25 * PlayState.singleton.rightGun.spreadLevel * 0.8))
			{
				PlayState.singleton.money -= Math.floor(15 + 25 * PlayState.singleton.rightGun.spreadLevel * 0.8);
				PlayState.singleton.rightGun.spreadLevel++;
				PlayState.singleton.leftGun.spreadLevel++;
				PlayState.singleton.rightGun.spread *= 0.9;
				PlayState.singleton.leftGun.spread *= 0.9;
				set();
			}
		}
		public function buyBulSpeed():void
		{
			if (visible && PlayState.singleton.money >= (10 + 30 * PlayState.singleton.rightGun.speedLevel))
			{
				PlayState.singleton.money -= (10 + 30 * PlayState.singleton.rightGun.speedLevel);
				PlayState.singleton.rightGun.speedLevel++
				PlayState.singleton.leftGun.speedLevel++;
				PlayState.singleton.rightGun.speed += 10;
				PlayState.singleton.leftGun.speed += 10;
				set();
			}	
		}
		public function buyRate():void
		{
			if (visible && PlayState.singleton.money >= Math.floor(40 + 25 * PlayState.singleton.rightGun.rateLevel * 0.85))
			{
				PlayState.singleton.money -= Math.floor(40 + 25 * PlayState.singleton.rightGun.rateLevel * 0.85);
				PlayState.singleton.rightGun.rateLevel++;
				PlayState.singleton.leftGun.rateLevel++;
				PlayState.singleton.rightGun.rate *= 0.9;
				PlayState.singleton.leftGun.rate *= 0.9;
				set();
			}	
		}
		
		public function buyMovSpeed():void
		{
			if (visible && PlayState.singleton.money >= Math.floor(50 + 25 * PlayState.singleton.rightGun.moveSpeedLevel * 1.2))
			{
				PlayState.singleton.money -= Math.floor(50 + 25 * PlayState.singleton.rightGun.moveSpeedLevel * 1.2);
				PlayState.singleton.rightGun.moveSpeedLevel++;
				PlayState.singleton.leftGun.moveSpeedLevel++;
				PlayState.singleton.rightGun.movespeed += 20;
				PlayState.singleton.leftGun.movespeed += 20;
				set();
			}	
		}
		public function buyHealth():void
		{
			if (visible && PlayState.singleton.money >= 15 && PlayState.singleton.health < PlayState.singleton.maxHealth)
			{
				PlayState.singleton.money -= 15;
				PlayState.singleton.health++;
				set();
			}
		}
		public function buyMaxHealth():void
		{
			if (visible && PlayState.singleton.money >= (140 + (PlayState.singleton.maxHealth - 9) * 10))
			{
				PlayState.singleton.money -= (140 + (PlayState.singleton.maxHealth - 9) * 10);
				PlayState.singleton.maxHealth++;
				PlayState.singleton.health++;
			}
		}
	}

}