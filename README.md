# Tileframe

![Mou icon](https://cdn2.iconfinder.com/data/icons/large-svg-icons/512/cube_blue_rss_black_add_draw-256.png)

=========

## Overview:
Tileframe contains functions to add a frame arround an image. The frame can consist 2 different colours so that it creates a 3D illusion. One color for the uper and left part, and one for the botom right part (by taking into account the corners of the rectangle so that it seems real). 

=========

### Init:
To use first get an instance of it by calling:

var frame:TileFrame = TileFrame.getInstance();

</br></br>




#### To draw on TOP of the image
**(image keeps its size but the last pixels towards the edge get transformed to a frame)**

Use __drawFrameOnTopOfImg__ like so:

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



	//For example:
	
	frame.drawFrameOnTopOfImg( image, image.width, image.height );

</br></br></br></br></br></br></br></br></br>






#### To draw a frame arround the image: 

**(image gets resized to whatever the thickness of the frame is x2)**

Use __drawFrameReplacingImg__ like so:

		/**	drawFrameReplacingImg
		*	Adds a frame on an img REPLACING any pixels if they exist. If the img size is more than MAX_ASSET_SIZE (defined in the beggining of the file), then the new img will have MAX MAX_ASSET_SIZE. Then DISPOSES the given bitmap data.
		* @param target  - The target img
		* @param fWidth   - The frame width
		* @param fHeight  - The frame height
		* @param thickness - The frame thickness
		* @param frameAlpha  - The frame alpha (0 = transparent)
		* @param darkColour  - The frames top,left sides colour
		* @param brightColour  - The frames bottom,right sides colour
		* @return  -  a new img with the frame drawn on it. Be sure to destroy the last img to save ram
		*/



	//For example:
	
	frame.drawFrameReplacingImg( image, image.width, image.height );
	
That will create a frame ARROUND (I cant stress this enough) of the image edges. That means the image will get +1 pixel in each side since we set the thickness to 1 by default.
Notice the default color is 0xFF3B3131 (FF stands for full opacity (You can mess with color transparency here also). The color used is 3B3131. )
</br></br></br></br></br></br></br></br></br>








> I hope this helps you, you are free to use it anyway you want.





I do not claim any rights for any images.


