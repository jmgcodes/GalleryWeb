/*
* gallery.js @VERSION
*
* Copyright 2014, Akiho Nagao http://webreak.jp
* Date: @DATE
*/

(function( $ ){

	// must be this design  HTML
	// <div class="your_class">
	//  <h2>title</h2>
	//  <div><img src="url.img" /></div>
	//  <div><img src="url.img" /></div>
	//  <div><img src="url.img" /></div>
	//  <div><img src="url.img" /></div>
	// </div>

  $.fn.gallery = function( ToBoxWidth, options ) {

		if(typeof ToBoxWidth == 'undefined') { 
			console.log('must need Option > boxWidth');
	    return this;
	  }
    // Setup options
    var boxwidth = ToBoxWidth || 120,
        settings = $.extend({
          'minFontSize' : 10,
          'maxFontSize' : 20
        }, options);

    return this.each(function(){

      // Store the object
      var $this = $(this);			

			var resizer = function () {

	  		var gallery_count = 0;
			  $this.children('div').each(function(){
			    gallery_count++;
			  });

		    var gallery_vertical_count = Math.floor( $this.width() / boxwidth );
			  var gallery_last_width;

			  switch(gallery_count%gallery_vertical_count){
			  	case 0:
			  	// case gallery_count:
					  gallery_last_width = boxwidth;
			  	break;
			  	default:
					  gallery_last_width = ( gallery_vertical_count - ( gallery_count % gallery_vertical_count ) + 1 ) * boxwidth ;
			  	break;
			  }

				$this.children('div:last-child').css('max-width', gallery_last_width);
				$this.children('h2').css('max-width', ( gallery_vertical_count * boxwidth ) );

      };

      // Call once to set.
      resizer();

      $(window).on('resize', resizer);

    });
  };
})( jQuery );