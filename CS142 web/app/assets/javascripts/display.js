
function Tagger(canvasId, feedbackId, x, y, w, h) {
    this.isMouseDown = false;
    this.canvasElement = document.getElementById(canvasId);
    this.element = document.getElementById(feedbackId);
    this.x_coord = document.getElementById(x);
    this.y_coord = document.getElementById(y);
    this.width = document.getElementById(w);
    this.height = document.getElementById(h);
    this.elementBorderWidth = parseInt(getComputedStyle(this.element).borderWidth);
    
    var obj = this;
    this.canvasElement.onmousedown = function(event) {
        obj.mouseDown(event);
    }
    //alert(this.x_coord);
}

Tagger.prototype.mouseDown = function(event) {

    event.preventDefault();

    var obj = this;

    this.oldMoveHandler = document.body.onmousemove;
    document.body.onmousemove = function(event) {
        obj.mouseMove(event);
    }
    this.oldUpHandler = document.body.onmouseup;
    document.body.onmouseup = function(event) {
        obj.mouseUp(event);
    }

    this.anchorXAbsolute = event.pageX;
    this.anchorYAbsolute = event.pageY;

    this.parentLeftXAbsolute = Tagger.absoluteXOffset(this.canvasElement);
    this.parentRightXAbsolute = Tagger.absoluteXOffset(this.canvasElement) + this.canvasElement.clientWidth;
    this.parentTopYAbsolute = Tagger.absoluteYOffset(this.canvasElement);
    this.parentBottomYAbsolute = Tagger.absoluteYOffset(this.canvasElement) + this.canvasElement.clientHeight;

    this.element.style.width = "0px";
    this.element.style.height = "0px";
    this.element.style.left = this.xCoordRelativeToCanvas(this.anchorXAbsolute) + "px";
    this.element.style.top = this.yCoordRelativeToCanvas(this.anchorYAbsolute) + "px";

    this.updateHiddenFields();

    this.isMouseDown = true;
    //alert(this.x_coord)
}

Tagger.prototype.mouseMove = function(event) {
    if (!this.isMouseDown) {
        return;
    }

    //alert("mouse move");

    var newWidth = event.pageX - this.anchorXAbsolute;

    // Check if the width is out of boundary
    var maxWidth = this.parentRightXAbsolute - this.anchorXAbsolute - 2 * this.elementBorderWidth; /* adjust for border on both sides */
    var minWidth = this.parentLeftXAbsolute - this.anchorXAbsolute;
    newWidth = Math.max(newWidth, minWidth);
    newWidth = Math.min(newWidth, maxWidth);

    if (newWidth >= 0){
        this.element.style.left = this.xCoordRelativeToCanvas(this.anchorXAbsolute) + "px";
        this.element.style.width = newWidth + "px";
    }
    else{ /* if mouse moved to the left of anchor we have to move the anchor x coord to the x coord of the event */
        this.element.style.left = this.xCoordRelativeToCanvas(this.anchorXAbsolute - Math.abs(newWidth)) + "px";
        this.element.style.width = Math.abs(newWidth) + "px";
    }

     var newHeight = event.pageY - this.anchorYAbsolute;
     var maxHeight = this.parentBottomYAbsolute - this.anchorYAbsolute - 2 * this.elementBorderWidth;  /* adjust for border on both sides */
     var minHeight = this.parentTopYAbsolute - this.anchorYAbsolute;
     newHeight = Math.max(newHeight, minHeight);
     newHeight = Math.min(newHeight, maxHeight);
 
     if (newHeight >= 0){
         this.element.style.top = this.yCoordRelativeToCanvas(this.anchorYAbsolute) + "px";
         this.element.style.height = newHeight + "px";
     }
     else{ /* if mouse moved to the above anchor we have to move the anchor y coord to the y coord of the event */
         this.element.style.top = this.yCoordRelativeToCanvas(this.anchorYAbsolute - Math.abs(newHeight)) + "px";
         this.element.style.height = Math.abs(newHeight) + "px";
     }

     this.updateHiddenFields();

     
    
}

Tagger.prototype.mouseUp = function(event) {
    this.isMouseDown = false;
    document.body.onmousemove = this.oldMoveHandler;
    document.body.onmouseup = this.oldUpHandler;
    console.log("mouseUp");
    //alert(this.width)
}

Tagger.prototype.updateHiddenFields = function ()
{
    this.x_coord.value = this.element.offsetLeft;
    this.y_coord.value = this.element.offsetTop;
    this.width.value = this.element.clientWidth;
    this.height.value = this.element.clientHeight;
    console.log(this.x_coord);
    console.log(this.y_coord);
    console.log(this.width);
    console.log(this.height);
    
}


Tagger.prototype.xCoordRelativeToCanvas = function (xCoord)
{
    var result = xCoord - Tagger.absoluteXOffset(this.canvasElement);

    /* Clip coordinate to be inside canvas */
    result = Math.min(this.canvasElement.clientWidth, result);
    result = Math.max(0, result);

    return result;
}

Tagger.prototype.yCoordRelativeToCanvas = function (yCoord)
{
    var result = yCoord - Tagger.absoluteYOffset(this.canvasElement);

    /* Clip coordinate to be inside canvas */
    result = Math.min(this.canvasElement.clientHeight, result);
    result = Math.max(0, result);

    return result;
}


Tagger.absoluteXOffset = function(element) {
    var left = 0;

    do {
        left += element.offsetLeft || 0;
        element = element.offsetParent;
    } while(element);

    return left;
}
Tagger.absoluteYOffset = function(element) {
    var top = 0;

    do {
        top += element.offsetTop  || 0;
        element = element.offsetParent;
    } while(element);

    return top;
}

