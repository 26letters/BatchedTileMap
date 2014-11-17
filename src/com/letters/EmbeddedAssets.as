package com.letters
{
    public class EmbeddedAssets
    {
       	[Embed(source="../../../bin/assets/map/maptiles.xml", mimeType="application/octet-stream")]
		public static const maptiles_xml:Class;
        
        [Embed(source = "../../../bin/assets/map/maptiles.png")]
		public static const maptiles:Class;
		
		[Embed(source = "../../../bin/assets/map/map.tmx", mimeType = "application/octet-stream")]
		public static const tiled_map:Class;
    }
}