Tileframe
=========

This file contains functions to add a frame arround an image. The frame can consist 2 different colours so that it creates a 3D illusion. One color for the uper and left part, and one for the botom right part (by taking into account the corners of the rectangle so that it seems real). Use it freely.




To use first get an instance of it by calling:

var frame:TileFrame = TileFrame.getInstance();


If you wish to add a frame ON TOP of an image you can call

/**	drawFrameOnTopOfImg
		*	Adds a frame on TOP of an excisting img.
		* @param target  - The target img
		* @param fWidth   - The frame width
		* @param fHeight  - The frame height
		* @param thickness - [optional] The frame thickness (default=1)
		* @param frameAlpha  - [optional] The frame alpha (0 = transparent)  (default=0xFF3B3131)
		* @param darkColour  - [optional] The frames top,left sides colour (default=0xFF736F6E)
		* @param brightColour  - [optional] The frames bottom,right sides colour (default=1)
		* @return  -  the same img you imported but with a frame on top of it
		*/
An example would be:

frame.drawFrameOnTopOfImg( image, image.width, image.height );

That will create a frame ARROUND (I cant stress this enough) of the image edges. That means the image will get +1 pixel in each side since we set the thickness to 1 by default.
Notice the default color is 0xFF3B3131 (FF stands for full opacity (You can mess with color transparency here also). The color used is 3B3131. )



If you wish to replace the image instead of placing the border arround the image then use:

frame.drawFrameReplacingImg( image, image.width, image.height );

the same way you did above.

/**	drawFrameReplacingImg
	     *	Adds a frame on an img REPLACING any pixels if they exist. If the img size is more than MAX_ASSET_SIZE, then the new img will have MAX MAX_ASSET_SIZE. Then DISPOSES the given bt dt
	     * @param target  - The target img
	     * @param fWidth   - The frame width
	     * @param fHeight  - The frame height
	     * @param thickness - The frame thickness
	     * @param frameAlpha  - The frame alpha (0 = transparent)
	     * @param darkColour  - The frames top,left sides colour
	     * @param brightColour  - The frames bottom,right sides colour
	     * @return  -  a new img with the frame drawn on it. Be sure to destroy the last img to save ram
	     */
