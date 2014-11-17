package com.letters
{
	import com.letters.map.GameMap;
	import com.senocular.utils.KeyObject;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import starling.core.Starling;
	import starling.display.Shape;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author Aditya
	 */
	public class GameScreen extends Sprite
	{
		private var _gameMap:GameMap;
		
		private const HERO_SPEED:Number = 5;
		
		private var _posX:uint = 150;
		private var _posY:uint = 80;
		
		private var _view:Rectangle;
		private var _viewWidth:Number = 440;
		private var _viewHeight:Number = 440;
		
		private var _gameWorld:Sprite;
		private var _baseBoundary:Shape;
		private var _hero:Shape;
		
		private var keyObject:KeyObject;
		private var grid:Sprite;
		
		public function GameScreen()
		{
			super();
			
			_gameWorld = new Sprite();
			_gameWorld.x = _posX;
			_gameWorld.y = _posY;
			this.addChild(_gameWorld);
			
			_gameMap = new GameMap();
			_gameWorld.addChild(_gameMap);
			_gameMap.drawWholeMap();
			
			_baseBoundary = new Shape();
			_baseBoundary.graphics.lineStyle(2, 0xff0000);
			_baseBoundary.graphics.drawRect(0, 0, _gameMap.width, _gameMap.height);
			_gameWorld.addChild(_baseBoundary);
			
			_hero = new Shape();
			_hero.graphics.beginFill(0, 0.5);
			_hero.graphics.drawCircle(0, 0, 20);
			_hero.graphics.endFill();
			_gameWorld.addChild(_hero);
			
			_view = new Rectangle(0, 0, _viewWidth, _viewHeight);
			keyObject = new KeyObject(Starling.current.nativeStage);
			
			addGrid(_viewWidth/_gameMap.tileMap.tileWidth, _viewHeight/_gameMap.tileMap.tileHeight);
		}
		
		public function update():void
		{
			if (keyObject.isDown(Keyboard.UP))
			{
				_hero.y = (_hero.y >= 0) ? (_hero.y - HERO_SPEED) : 0;
				
				if (_hero.y >= _view.height / 2 && _hero.y < (_baseBoundary.height - _view.height/2))
				{
					_gameWorld.y += HERO_SPEED;
				}
			}
			else if (keyObject.isDown(Keyboard.RIGHT))
			{
				_hero.x = (_hero.x <= _baseBoundary.width) ? (_hero.x + HERO_SPEED) : _baseBoundary.width;
					
				if (_hero.x >= _view.width / 2 && _hero.x < (_baseBoundary.width - _view.width/2))
				{
					_gameWorld.x -= HERO_SPEED;
				}
			}
			else if (keyObject.isDown(Keyboard.DOWN))
			{
				_hero.y = (_hero.y <= _baseBoundary.height) ? (_hero.y + HERO_SPEED) : _baseBoundary.height;
				
				if (_hero.y >= _view.height / 2 && _hero.y < (_baseBoundary.height - _view.height/2))
				{
					_gameWorld.y -= HERO_SPEED;
				}
			}
			else if (keyObject.isDown(Keyboard.LEFT))
			{
				_hero.x = (_hero.x >= 0) ? (_hero.x - HERO_SPEED) : 0;
				
				if (_hero.x >= _view.width / 2 && _hero.x < (_baseBoundary.width - _view.width/2))
				{
					_gameWorld.x += HERO_SPEED;
				}
			}
		}
		
		private function addGrid(col:uint, row:uint):void
		{
			grid = new Sprite();
			var gridLines:Shape = new Shape();
			gridLines.graphics.lineStyle(1);
			for (var i:int = 0; i <= col; i++)
			{
				gridLines.graphics.moveTo(i * _gameMap.tileMap.tileWidth, 0);
				gridLines.graphics.lineTo(i * _gameMap.tileMap.tileWidth, row * _gameMap.tileMap.tileWidth);
					
				for (var j:int = 0; j <= row; j++)
				{
					gridLines.graphics.moveTo(0, j * _gameMap.tileMap.tileHeight);
					gridLines.graphics.lineTo(col * _gameMap.tileMap.tileHeight, j * _gameMap.tileMap.tileHeight);
				}
			}
			
			grid.addChild(gridLines);
			this.addChild(grid);
			grid.alpha = 0.2;
			grid.x = _posX;
			grid.y = _posY;
		}
		
		public function toggleGrid():void 
		{
			grid.visible = grid.visible ? false : true;
		}
		
		public function get gameMap():GameMap
		{
			return _gameMap;
		}
	}

}