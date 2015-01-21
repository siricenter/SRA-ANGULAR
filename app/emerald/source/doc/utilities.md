## Utilities

* `.high` - adds `height: 100%` to the element
* `.fullscreen` - makes the element take the full screen

* `.vpadded` - adds padding to top/bottom
* `.vpadded-row` - adds padding to all the children inside (first level)
* `.hpadded` - adds a horizontal padding to left/right
* `.padded` - adds padding on all sides
* `.no-padding` - removes padding from all sides
* `.padded-DIRECTION` - adds padding to direction (top, left, right, bottom)
* `.no-padding-DIRECTION` - removes padding from direction (top, left, right, bottom)
* `.no-padding-v` - removes vertical padding (top,bottom)
* `.no-padding-h` - removes horizontal padding (left, right)


* `.no-margin` - removes margin from all sides
* `.no-margin-DIRECTION` - removes margin from direction (top, left, right, bottom)


* `.no-border-radius` - removes border-radius from all corners


* `.push-top` - adds a positive margin-top to a container
* `.push-bottom` - adds a positive margin-bottom to a container
* `.pull-top` - adds a negative margin-top to a container

* `.vertical-text-left` - rotates the text to the left
* `.vertical-text-right` - rotates the text to the right 
* `.circle` - adds a 50% border-radius
* `.grayscale` - removes the saturation from an element (makes it look.. gray)

* `.pull-DIRECTION-SIZE`, `.push-DIRECTION-SIZE` - adds a margin (positive-push, negative-pull) to direction (can be top,left,bottom,right) , and to screen size (can be xs, sm, md, lg).  
Example: `.pull-left-md` will pull the content with a `-15px` margin-left until it hits `md` screens (from mobile to md)
* `.no-pull-SIZE` - will cancel any margin done by `.pull-DIRECTION-SIZE` or `.push-DIRECTION-SIZE` for a specific size  
Example: you want to pull a container to the left on all screens except mobile xs:  add `pull-left-lg no-pull-xs`


* `.pull-center` - centers a container between bootstrap's pull-left and pull-right elements

* `.component-shadow` - adds a large shadow to a container
* `.text-component-shadow` - adds a large shadow to a text (used in jumpto menu)