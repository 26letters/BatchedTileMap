package com.letters.map 
{
	/**
	 * ...
	 * @author Aditya
	 */
	public class Tileset 
	{
		private var _firstgid:uint;
		private var _name:String;
		private var _tileswidth:Number
		private var _tilesheight:Number;
		
		private var _imgName:String;
		private var _imgWidth:Number;
		private var _imgHeight:Number;
		
		public function Tileset(firstGid:uint, name:String, tilesWidth:Number, tilesHeight:Number, imgName:String, imgWidth:Number, imgHeight:Number) 
		{
			_firstgid = firstGid;
			_name = name;
			_tileswidth = tilesWidth;
			_tilesheight = tilesHeight;
			
			_imgName = imgName;
			_imgWidth = imgWidth;
			_imgHeight = imgHeight;
		}
		
		public function getCols():uint
		{
			return _imgWidth / _tileswidth;
		}
		
		public function getRows():uint 
		{
			return _imgHeight / _tilesheight;
		}
		
		public function get firstgid():uint 
		{
			return _firstgid;
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		public function get tileswidth():Number 
		{
			return _tileswidth;
		}
		
		public function get tilesheight():Number 
		{
			return _tilesheight;
		}
		
		public function get imgName():String 
		{
			return _imgName;
		}
		
		public function get imgWidth():Number 
		{
			return _imgWidth;
		}
		
		public function get imgHeight():Number 
		{
			return _imgHeight;
		}
		
	}

}