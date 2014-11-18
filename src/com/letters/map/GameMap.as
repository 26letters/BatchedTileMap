package com.letters.map
{
	import com.letters.Game;
	import starling.display.Image;
	import starling.display.QuadBatch;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Aditya
	 */
	public class GameMap extends Sprite
	{
		private var _tileMap:TileMap;
		private var qb:QuadBatch;
		
		public function GameMap()
		{
			super();
			
			_tileMap = new TileMap(Game.assets.getXml("tiled_map"));
			
			qb = new QuadBatch();
			this.addChild(qb);
		}
		
		public function drawWholeMap():void 
		{
			for (var i:int = 0; i < _tileMap.layers.length; i++) 
			{
				drawMapLayer(qb, i, 0, _tileMap.mapCols, 0, _tileMap.mapRows);
			}
		}
		
		public function drawMapLayer(quadBatchLayer:QuadBatch, layerNum:uint = 0, fromCol:uint = 0, toCol:uint = 10, fromRow:uint = 0, toRow:uint = 10):void
		{
			var txt:Texture;
			var img:Image;
				
			for (var i:int = fromCol; i < toCol; i++)
			{
				for (var j:int = fromRow; j < toRow; j++)
				{
					txt = _tileMap.getTileTexture(layerNum, i, j);
					
					if (txt != null)
					{
						if (img == null)
						{
							img = new Image(txt);
						}
						else
						{
							img.texture = txt;
							img.readjustSize(); //as the tiles are of different size, the size of the texture might change
						}
						
						img.x = (i - fromCol) * _tileMap.tileWidth;
						img.y = (j - fromRow) * _tileMap.tileHeight;
						
						if (img.height > _tileMap.tileHeight)
						{
							img.y -= (img.height - _tileMap.tileHeight);
						}
						
						quadBatchLayer.addImage(img);
					}
				}
			}
		}
		
		public function drawMap(fromCol:uint, fromRow:uint, toCol:uint, toRow:uint):void 
		{
			for (var i:int = 0; i < _tileMap.layers.length; i++) 
			{
				drawMapLayer(qb, i, fromCol, toCol, fromRow, toRow);
			}
		}
		
		public function get tileMap():TileMap 
		{
			return _tileMap;
		}
	}

}
