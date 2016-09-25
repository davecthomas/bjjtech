$( document ).ready( function() {
  const maxlenSearchStrDisplayed = 6;
  if ( searchStr.length > 0 ) {
    var searchStringTrunc;
    if ( searchStr.length > maxlenSearchStrDisplayed ) {
      searchStr = searchStr.slice( 0, maxlenSearchStrDisplayed ) + "...";
    }
    $( '#return_to_search' ).html(
      '<i class="fa fa-arrow-left" aria-hidden="true"></i>&nbsp;<i class="fa fa-search" aria-hidden="true">"' +
      searchStr + '"' );
    // Make the "return to search" button parent div as tall as the title area next to it
    $( '#return_to_search_parent' ).height( $( '#gettech_name' ).height() );
    $( '#return_to_search_parent' ).show();
    $( '[data-toggle="tooltip"]' ).tooltip();
    $( '#return_to_search' ).width( $( '#return_to_search_parent' ).width() - 30 );
  }

  // Make the left pane as tall as the right (only important on landscape large screens)
  $( '#tech_detail_left_pane' ).height( $( '#tech_detail_right_pane' ).height() );

  // Make the image tha same width as the content-panel-tech div
  $( '#bjjt_image_img' ).width( $( '.content-panel-left' ).width() );


  function Utils() {

  }

  Utils.prototype = {
    constructor: Utils,
    isElementInView: function( element, fullyInView ) {
      var pageTop = $( window ).scrollTop();
      var pageBottom = pageTop + $( window ).height();
      var elementTop = $( element ).offset().top;
      var elementBottom = elementTop + $( element ).height();

      if ( fullyInView === true ) {
        return ( ( pageTop < elementTop ) && ( pageBottom > elementBottom ) );
      } else {
        return ( ( elementBottom <= pageBottom ) && ( elementTop >= pageTop ) );
      }
    }
  };

  var Utils = new Utils();

  $( "#tech_detail_left_pane" ).scroll( function() {
    var isElementInView = Utils.isElementInView( $( '#ytplayer' ), false );

    if ( isElementInView ) {
      console.log( 'in view' );
    } else {
      console.log( 'out of view' );
    }
  } );



} );

$( document ).on( 'click', '#return_to_search', function() {
  window.location = root_url + "tech/text/" + searchStr;
} );

$( document ).on( 'click', "#dave", function() {
  alert( "hi" );
} );


// Video and image responsiveness follows parent div
// Make the image tha same width as the content-panel-tech div
$( window ).on( 'resize', function() {
  $( '#ytplayer' ).width( $( '.content-panel-tech' ).width() );
  $( '#bjjt_image_img' ).width( $( '.content-panel-left' ).width() );
  $( '#tech_detail_left_pane' ).height( $( '#tech_detail_right_pane' ).height() );
  $( '#return_to_search_parent' ).height( $( '#gettech_name' ).height() );
  $( '#return_to_search' ).width( $( '#return_to_search_parent' ).width() - 30 );
  if ( $( '#return_to_search' ).innerWidth() > $( '#return_to_search_parent' ).innerWidth() ) {
    console.log( $( '#return_to_search' ).innerWidth() + " " + $( '#return_to_search_parent' ).innerWidth() );
    $( '#return_to_search' ).innerWidth( $( '#return_to_search_parent' ).innerWidth() - 30 );
  }

} );
