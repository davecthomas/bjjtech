function doSearch( str ) {
  $( '#search_title_replace' ).empty();
  $( '#search_title_replace' ).append( str );

  $.ajax( {
    url: api_url + "tech/text/" + str,
    success: function( result ) {
      $( '#num_search_techs' ).empty();
      $( '#search_techs' ).empty();
      var techs = result;
      if ( techs.status === 'success' ) {
        var len = techs.data.length;
        $( '#num_search_techs' ).append( len );

        for ( i = 0; i < len; i++ ) {
          if ( techs.data[ i ].videoid ) {
            video = '<i class="fa fa-video-camera"></i>&nbsp;';
          } else {
            video = "&emsp;";
          }
          $( '#search_techs' ).append(
            "<a href='#' class='list-group-item get_tech_search' id='" + techs.data[ i ].index +
            "' data-listindex='" + i + "' data-id='" + techs.data[ i ].index +
            "'><h5 class='list-group-item-heading'>" + video + "<strong>" + techs.data[ i ]
            .name + "</strong>(" + techs.data[ i ].topic_name + ")</h5></a>" );
        }
      }
    }
  } );

  $( '#search' ).addClass( 'open' );

}

$( function() {
  $( document ).on( 'click', '#bjjt_search', function() {
    doSearch( $( '#bjjt_searchtext' ).val() )
    return false;
  } );
  $( '#bjjt_searchtext' ).bind( "enterKey", function( e ) {
    doSearch( $( '#bjjt_searchtext' ).val() )
    return false;
  } );

  $( '#bjjt_searchtext' ).keyup( function( e ) {
    if ( e.keyCode == 13 ) {
      $( this ).trigger( "enterKey" );
    }
  } );
  $( document ).on( 'click', '#bjjt_brand', function() {
    var target = $( this ).attr( 'data-target' );
    window.location = target;
    return false;
  } );
  $( document ).on( 'click', '#bjjt_brand_ajj', function() {
    var target = $( this ).attr( 'data-target' );
    window.location = target;
    return false;
  } );
  $( document ).on( 'click', '#bjjt_dave', function() {
    window.location = "http://www.austinjujitsu.com/post/dave-thomas/";
    return false;
  } );

  $( 'a[href="#search"]' ).on( 'click', function( event ) {
    $( '#search' ).addClass( 'open' );
  } );
  $( document ).keyup( function( e ) {
    if ( e.keyCode == 27 ) { // escape key maps to keycode `27`
      $( "#search" ).removeClass( 'open' );
    }
  } );
  $( '.close' ).on( 'click', function( event ) {
    $( "#search" ).removeClass( 'open' );
    event.preventDefault();
  } );
  $( document ).on( 'click', '#search.close', function( event ) {
    $( "#search" ).removeClass( 'open' );
    event.preventDefault();
  } );
  $( '#search.close' ).on( 'click keyup', function( event ) {
    if ( event.target == this || event.target.className == 'close' || event.keyCode == 27 ) {
      $( "#search" ).removeClass( 'open' );
    }
  } );


  $( document ).on( 'click', '.get_tech_search', function() {
    var id = $( this ).attr( 'data-id' );
    window.location = root_url + "tech/" + id;
  } );

} );
