var search_results = true;

$( document ).ready( function() {
  // $( '#close_search_button' ).hide();
  $( '#search' ).addClass( 'open' );
  document.title = bjjtech_pagetitle;
  var len_topic_list = len;

  $( '#search_title_replace' ).append( techs.search );
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
} );
