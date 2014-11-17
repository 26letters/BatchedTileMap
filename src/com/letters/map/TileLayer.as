package com.letters.map 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Aditya
	 */
	public class TileLayer 
	{
		private var _layerName:String;
		private var _cols:uint;
		private var _row:uint;
		//private var _tiles:Array;
		private var _tiles:Dictionary;
		
		private var _tilesData:Array;
		
		public function TileLayer(layerName:String, cols:uint, rows:uint) 
		{
			_layerName = layerName;
			_cols = cols;
			_row = rows;
			
			_tilesData = new Array();
			_tiles = new Dictionary();
		}
		
		/*public function addTile(posID:uint, gID:uint):void 
		{
			var tile:Tile = new Tile(posID, gID);
			_tiles.push(tile);
		}*/
		
		public function addTile(posID:uint, gID:uint):void 
		{
			_tiles[posID] = gID;
		}
		
		public function get layerName():String 
		{
			return _layerName;
		}
		
		public function get cols():uint 
		{
			return _cols;
		}
		
		public function get row():uint 
		{
			return _row;
		}
		
		public function get tiles():Dictionary 
		{
			return _tiles;
		}
		
		public function get tilesData():Array 
		{
			return _tilesData;
		}
		
		public function set tilesData(value:Array):void 
		{
			_tilesData = value;
		}
		
	}

}