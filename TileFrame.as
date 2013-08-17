package com.sudoplz.TileFrame
{
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.Dictionary;

public class TileFrame
	{
		
		private static var instance:TileFrame;
		private static var allowInstantiation:Boolean;
		
        private var frames:Dictionary;

		public function TileFrame()
		{
			if (!allowInstantiation) {
				throw new Error("Error: Instantiation failed: Use TileFrame.getInstance() instead of new.");
			}
            frames = new Dictionary();
		}

    /**      drawFrameOnTopOfImg
     *        Adds a frame on TOP of an excisting img.
     * @param target  - The target img
     * @param fWidth   - The frame width
     * @param fHeight  - The frame height
     * @param thickness - The frame thickness
     * @param frameAlpha  - The frame alpha
     * @param darkColour  - The frames top,left sides colour
     * @param brightColour  - The frames bottom,right sides colour
     * @return  -  the same img you imported but with a frame on top of it
     */
		public function drawFrameOnTopOfImg( target:BitmapData, fWidth:Number, fHeight:Number , thickness:int = 2 , frameAlpha:Number = 1, darkColour:uint  = 0xFF3B3131, brightColour:uint = 0xFF736F6E):BitmapData
		{
            var frame: Sprite = frames[fWidth+"x"+fHeight];
			if (frames[fWidth+"x"+fHeight] == undefined)
			{
				frame = createFrame( fWidth, fHeight , thickness, darkColour, brightColour, frameAlpha );
                frames[fWidth+"x"+fHeight] = frame;
			}
            else
            {
                frame = frames[fWidth+"x"+fHeight];
            }
			 
			target.draw( frame );
            return target;
		}


    /**      drawFrameReplacingImg
     *        Adds a frame on an img REPLACING any pixels if they exist. If the img size is more than MAX_ASSET_SIZE, then the new img will have MAX MAX_ASSET_SIZE. Then DISPOSES the given bt dt
     * @param target  - The target img
     * @param fWidth   - The frame width
     * @param fHeight  - The frame height
     * @param thickness - The frame thickness
     * @param frameAlpha  - The frame alpha
     * @param darkColour  - The frames top,left sides colour
     * @param brightColour  - The frames bottom,right sides colour
     * @return  -  a new img with the frame drawn on it. Be sure to destroy the last img to save ram
     */
		public function drawFrameReplacingImg(target:BitmapData , fWidth:Number, fHeight:Number,  thickness:int = 1 , frameAlpha:Number = 1, darkColour:uint  = 0xFF3B3131, brightColour:uint = 0xFF736F6E):BitmapData
        {
                                                                                                         //remember max is MAX_ASSET_SIZE = 2048
            var newWidth:uint = (fWidth+2*thickness>Constants.MAX_ASSET_SIZE? Constants.MAX_ASSET_SIZE:fWidth+2*thickness);      //restraints for Fruitfly
            var newHeight:uint = (fHeight+2*thickness>Constants.MAX_ASSET_SIZE? Constants.MAX_ASSET_SIZE:fHeight+2*thickness);   //restraints for Fruitfly

            var frameArround:Sprite = createFrame( newWidth, newHeight, thickness, darkColour, brightColour, frameAlpha );

            var newImg:BitmapData = new BitmapData(newWidth,newHeight,true,0x00FFFFFF);

            //destPoint = where copypixels copies the pixels TO
            var destPoint:Point = new Point(1,1);

            var rect:Rectangle;
                                          //this rect is the INPUT copy pixels copies from
            var copyXFrom:uint = 0;
            var copyYFrom:uint = 0;
            var copyWidth:uint = newWidth;
            var copyHeight:uint = newHeight;

//            if (target.width==newWidth || ) //if the frame is on top of our img
//                rect = new Rectangle(1,1,newWidth-1,newHeight-1);   //then we make the copypixes copy 1 pixel less from eachside
            if (target.width==newWidth)
            {
                copyXFrom = 1;
                copyWidth = newWidth-2;
            }
            if (target.height==newHeight)
            {
                copyYFrom = 1;
                copyHeight = newHeight-2;
            }
            rect = new Rectangle(copyXFrom,copyYFrom,copyWidth,copyHeight);


            //copyPixels(source image, input position, width and height (where to get pixels from), output position (where to put pixels to in the new image)
            newImg.copyPixels(target, rect , destPoint);
            //newImg.threshold(target, target.rect, destPoint,"==", 0xFFFF0000 , 0x00000000, 0xFFFFFFFF, true);

            newImg.draw( frameArround );
            rect = null;
            frameArround = null;

            target.dispose();       //we dispose the old one
            target = newImg
            return target;
        }
		
		
		
		
		
		
		
		
		
		
		
		
		
		private function createFrame( fWidth:Number, fHeight:Number , thickness:int , darkColour:uint , brightColour:uint, frameAlpha:Number) : Sprite
		{
			var frameShape:Sprite = new Sprite();
			
			//lets create the dark parts first (bottom and right part of the frame)
			
			//we need a dark triangle for bot left (part of the bottom frame)
			var botLeftDarkTriangle:Sprite = getDarkTriangle(thickness,darkColour, frameAlpha);
			botLeftDarkTriangle.x = 0;
			botLeftDarkTriangle.y = fHeight-thickness //fix the point 0,0 of the triangle
			
			//also I need the same dark triangle top right
			var topRightDarkTriangle:Sprite = getDarkTriangle(thickness,darkColour, frameAlpha);
			topRightDarkTriangle.x = fWidth - thickness;
			topRightDarkTriangle.y = 0;
			
			//also i need the dark bot Line
			var botDarkLine:Sprite = getHorizontalLine(thickness, fWidth, darkColour, frameAlpha);
			botDarkLine.x = thickness;
			botDarkLine.y = fHeight-thickness;
			
			//also i need the dark vertical right line
			var rightDarkLine:Sprite = getVerticalLine(thickness, fHeight, darkColour, frameAlpha);
			rightDarkLine.x = fWidth-thickness;
			rightDarkLine.y = thickness;
			
			
			// now lets create the bright parts first (top and left part of the frame)
			
			//we need a bright triangle for bot left (part of the bottom frame)
			var botLeftBrightTriangle:Sprite = getBrightTriangle(thickness,brightColour, frameAlpha);
			botLeftBrightTriangle.x = 0;
			botLeftBrightTriangle.y = fHeight-thickness //fix the point 0,0 of the triangle
			
			//also I need the same bright triangle top right
			var topRightBrightTriangle:Sprite = getBrightTriangle(thickness,brightColour, frameAlpha);
			topRightBrightTriangle.x = fWidth - thickness;
			topRightBrightTriangle.y = 0;
			
			//also i need the bright top Line
			var botBrightLine:Sprite = getHorizontalLine(thickness, fWidth, brightColour, frameAlpha);
			botBrightLine.x = thickness;
			botBrightLine.y = 0;
			
			//also i need the bright vertical left line
			var rightBrightLine:Sprite = getVerticalLine(thickness, fHeight, brightColour, frameAlpha);
			rightBrightLine.x = 0;
			rightBrightLine.y = 0;
			
			
			frameShape.addChild(botDarkLine);
			frameShape.addChild(botBrightLine);
			frameShape.addChild(rightDarkLine);
			frameShape.addChild(rightBrightLine);
			frameShape.addChild(botLeftDarkTriangle);
			frameShape.addChild(botLeftBrightTriangle);
			frameShape.addChild(topRightDarkTriangle);
			frameShape.addChild(topRightBrightTriangle);
			return frameShape
		}
		
		
		private function getDarkTriangle( thickness:int, darkColour:uint, alpha:Number) : Sprite
		{
			var botLeft:Point = new Point(0,thickness);
			var botRight:Point = new Point(thickness ,0);
			var topRight:Point = new Point(thickness,thickness);	
			
			var verticies:Vector.<Number> = Vector.<Number>([botLeft.x, botLeft.y, botRight.x, botRight.y, topRight.x, topRight.y]);
			
			var darkTriangle:Sprite = new Sprite();
			darkTriangle.graphics.beginFill(darkColour, alpha);
			darkTriangle.graphics.drawTriangles(verticies);
			darkTriangle.graphics.endFill();
			
			return darkTriangle;
		}
		
		private function getBrightTriangle( thickness:int , brightColour:uint, alpha:Number) : Sprite
		{
			var botLeft:Point = new Point(0,0);
			var topLeft:Point = new Point(0,thickness);
			var topRight:Point = new Point(thickness,0);	
			
			var verticies:Vector.<Number> = Vector.<Number>([botLeft.x, botLeft.y, topLeft.x, topLeft.y, topRight.x, topRight.y]);
			
			var brightTriangle:Sprite = new Sprite();
			brightTriangle.graphics.beginFill(brightColour, alpha);
			brightTriangle.graphics.drawTriangles(verticies);
			brightTriangle.graphics.endFill();
			
			return brightTriangle;
		}
		
		private function getHorizontalLine( thickness:int , lineLength:Number, colour:uint, alpha:Number ):Sprite
		{
			
			var horizontalLine:Sprite = new Sprite();
			horizontalLine.graphics.beginFill(colour, alpha);
			horizontalLine.graphics.drawRect(0,0,lineLength-thickness-thickness,thickness);
			horizontalLine.graphics.endFill();
			
			return horizontalLine;
		}
		
		private function getVerticalLine( thickness:int , lineLength:Number, colour:uint, alpha:Number ):Sprite
		{
			
			var verticalLine:Sprite = new Sprite();
			verticalLine.graphics.beginFill(colour, alpha);
			verticalLine.graphics.drawRect(0,0,thickness,lineLength-thickness);
			verticalLine.graphics.endFill();
			
			return verticalLine;
		}
		
		public static function getInstance():TileFrame {
			if (instance == null) {
				allowInstantiation = true;
				instance = new TileFrame();
				allowInstantiation = false;
			}
			return instance;
		}
	}
}
