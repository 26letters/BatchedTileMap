package com.letters.map
{
	import com.letters.Game;
	import com.letters.utils.Base64;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Aditya
	 */
	public class TileMap
	{
		private var _tilesTexture:Dictionary;
		private var _tiledMapXML:XML;
		
		private var _tileWidth:Number;
		private var _tileHeight:Number;
		private var _mapCols:uint;
		private var _mapRows:uint;
		private var _tileSets:Array;
		private var _layers:Array;
		
		private var _region:Rectangle;
		
		public function TileMap(tiledMap:XML)
		{
			//get all the tilesets data from the xml
			_tiledMapXML = tiledMap;
			
			_tileWidth = Number(_tiledMapXML.@tilewidth);
			_tileHeight = Number(_tiledMapXML.@tileheight);
			_mapCols = uint(_tiledMapXML.@width);
			_mapRows = uint(_tiledMapXML.@height);
			
			_tilesTexture = new Dictionary();
			
			loadTileSet();
			loadLayers();
		
			_region = new Rectangle();
		}
		
		private function loadTileSet():void
		{
			_tileSets = new Array();
			
			for (var i:int = 0; i < _tiledMapXML.tileset.length(); i++)
			{
				var tileSetXML:XML = _tiledMapXML.tileset[i];
				var tileSet:Tileset = new Tileset(uint(tileSetXML.@firstgid), String(tileSetXML.@name), Number(tileSetXML.@tilewidth), Number(tileSetXML.@tileheight), String(tileSetXML.image.@source), Number(tileSetXML.image.@width), Number(tileSetXML.image.@height));
				_tileSets.push(tileSet);
			}
		}
		
		private function loadLayers():void
		{
			_layers = new Array();
			
			for (var i:int = 0; i < _tiledMapXML.layer.length(); i++)
			{
				var layerXML:XML = _tiledMapXML.layer[i];
				var layer:TileLayer = new TileLayer(layerXML.@name, uint(layerXML.@width), uint(layerXML.@height));
				
				var ba:ByteArray = Base64.decode(layerXML.data);
				ba.uncompress();
				
				var data:Array = new Array();
				
				for (var j:int = 0; j < ba.length; j += 4)
				{
					// Get the grid ID
					
					var a:int = ba[j];
					var b:int = ba[j + 1];
					var c:int = ba[j + 2];
					var d:int = ba[j + 3];
					
					var gid:int = a | b << 8 | c << 16 | d << 24;
					data.push(gid);
					
					//trace(j, gid);
				}
				
				layer.tilesData = data;
				_layers.push(layer);
			}
		}
		
		public function getTileTexture(layerNum:uint, col:int, row:int):Texture
		{
			var posID:uint = row * _mapCols + col;
			var gID:uint = (_layers[layerNum] as TileLayer).tilesData[posID];
			
			if (gID == 0)
				return null;
			
			var tileSet:Tileset = getTileset(gID);
			//trace((_layers[layerNum] as TileLayer).layerName, "PosID:", posID, "gID:", gID, "Col:", col, "Row:", row, tileSet.name);
			var yOff:uint = Math.ceil((gID - tileSet.firstgid + 1) / tileSet.getCols()) - 1;
			var xOff:uint = (gID - tileSet.firstgid + 1) - (tileSet.getCols() * yOff) - 1;
			
			//trace(xOff, yOff, gID, gID - tileSet.firstgid);
			_region.setTo(tileSet.tileswidth * xOff, tileSet.tilesheight * yOff, tileSet.tileswidth, tileSet.tilesheight);
			
			return Texture.fromTexture(Game.assets.getTexture(tileSet.name), _region);
		}
		
		private function getTileset(gID:uint):Tileset
		{
			for (var i:int = _tileSets.length - 1; i >= 0; i--) 
			{
				var _tileSet:Tileset = _tileSets[i];
				if (gID >= _tileSet.firstgid) 
				{
					//trace("Tileset check:", _tileSet.name, _tileSet.firstgid, gID);
					return _tileSet;
				}
			}
			
			return null;
		}
		
		public function get tileWidth():Number 
		{
			return _tileWidth;
		}
		
		public function get tileHeight():Number 
		{
			return _tileHeight;
		}
		
		public function get layers():Array 
		{
			return _layers;
		}
		
		public function get mapCols():uint 
		{
			return _mapCols;
		}
		
		public function get mapRows():uint 
		{
			return _mapRows;
		}
	}

}