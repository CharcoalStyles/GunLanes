package 
{
	import flash.events.MouseEvent;
	import org.flixel.*;
	
	public class Main extends FlxGame
	{
		public function Main()
		{
			super(800, 480, PlayState);
			PlayState.touchPoints = new Array();
			
			FlxG.mouse.show();
			
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			addEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}
		
		public function mouseDown(e:MouseEvent):void
		{
			PlayState.touchPoints.push(new FlxPoint(e.stageX, e.stageY));
		}
		
		public function mouseMove(e:MouseEvent):void
		{
			if (PlayState.touchPoints.length == 1)
			{
				PlayState.touchPoints[0].x = e.stageX;
				PlayState.touchPoints[0].y = e.stageY;
			}
		}
		
		public function mouseUp(e:MouseEvent):void
		{
			PlayState.touchPoints.pop();
		}
	}
}