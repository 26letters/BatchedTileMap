package com.letters
{
	import com.letters.utils.ProgressBar;
	import flash.system.System;
	import flash.ui.Keyboard;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.KeyboardEvent;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	
	public class Game extends Sprite
	{
		[Embed(source="../../../bin/assets/fonts/Ubuntu-R.ttf",embedAsCFF="false",fontFamily="Ubuntu")]
		private static const UbuntuRegular:Class;
		
		private static var sAssets:AssetManager;
		private var mLoadingProgress:ProgressBar;
		private var gameScreen:GameScreen;
		
		public function Game()
		{
		}
		
		public function start(background:Texture, assets:AssetManager):void
		{
			sAssets = assets;
			addChild(new Image(background));
			
			mLoadingProgress = new ProgressBar(175, 20);
			mLoadingProgress.x = (background.width - mLoadingProgress.width) / 2;
			mLoadingProgress.y = background.height * 0.7;
			addChild(mLoadingProgress);
			
			assets.loadQueue(function(ratio:Number):void
				{
					mLoadingProgress.ratio = ratio;
					if (ratio == 1)
						Starling.juggler.delayCall(function():void
							{
								mLoadingProgress.removeFromParent(true);
								mLoadingProgress = null;
								showMainMenu();
							}, 0.15);
				});
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey);
		}
		
		private function showMainMenu():void
		{
			// now would be a good time for a clean-up 
			System.pauseForGCIfCollectionImminent(0);
			System.gc();
			
			//start here
			gameScreen = new GameScreen();
			this.addChild(gameScreen);
			//gameScreen.scaleX = gameScreen.scaleY = 0.5;
			this.addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFame);
		}
		
		private function onEnterFame(e:EnterFrameEvent):void 
		{
			gameScreen.update();
		}
		
		private function onKey(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.SPACE)
				Starling.current.showStats = !Starling.current.showStats;
			else if (event.keyCode == Keyboard.X)
				Starling.context.dispose();
			else if (event.keyCode == Keyboard.H)
				gameScreen.toggleGrid();
		}
		
		public static function get assets():AssetManager
		{
			return sAssets;
		}
	}
}