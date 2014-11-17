package com.letters.map 
{
	/**
	 * ...
	 * @author Aditya
	 */
	public class Tile 
	{
		private var _posID:uint;
		private var _gID:uint;
		
		public function Tile(posID:uint, gID:uint) 
		{
			_posID = posID;
			_gID = gID;
		}
		
		public function get posID():uint 
		{
			return _posID;
		}
		
		public function get gID():uint 
		{
			return _gID;
		}
		
	}

}