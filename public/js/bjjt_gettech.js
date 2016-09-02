$( "#bjjt_image_img" ).attr( "src", img_array[ current_image ] );
var txt = '<span class="fa-stack fa-3x bjj_image_num">' +
  '<i class="fa fa-circle-o fa-stack-2x"></i>' +
  '<strong class="fa-stack-1x"><span id="bjjt_image_num_fa">' + parseInt( current_image + 1 ) +
  '</span></strong>' +
  '</span>';
$( '#img_text_fa_imgnum' ).append( txt );

$( ".bjjt_image_chevron_left" ).on( 'click', function() {
  if ( ( current_image - 1 ) > -1 ) {
    $( '#bjjt_image_class_swapper_right' ).removeClass( "bjjt_image_chevron_disabled" );
    current_image--;
    if ( current_image == 0 ) {
      $( '#bjjt_image_class_swapper_left' ).addClass( "bjjt_image_chevron_disabled" );
    }
    $( "#bjjt_image_img" ).attr( "src", img_array[ current_image ] );
    var txt = '<span class="fa-stack fa-3x bjj_image_num">' +
      '<i class="fa fa-circle-o fa-stack-2x"></i>' +
      '<strong class="fa-stack-1x"><span id="bjjt_image_num_fa">' + parseInt( current_image + 1 ) +
      '</span></strong>' +
      '</span>';
    $( '#img_text_fa_imgnum' ).empty();
    $( '#img_text_fa_imgnum' ).append( txt );
  } else {
    $( '#bjjt_image_class_swapper_left' ).addClass( "bjjt_image_chevron_disabled" );
  }

} );
$( ".bjjt_image_chevron_right" ).on( 'click', function() {
  if ( ( current_image ) < ( numimages - 1 ) ) {
    $( '#bjjt_image_class_swapper_left' ).removeClass( "bjjt_image_chevron_disabled" );
    current_image++;
    if ( current_image == ( numimages - 1 ) ) {
      $( '#bjjt_image_class_swapper_right' ).addClass( "bjjt_image_chevron_disabled" );
    }
    $( "#bjjt_image_img" ).attr( "src", img_array[ current_image ] );
    var txt = '<span class="fa-stack fa-3x bjj_image_num">' +
      '<i class="fa fa-circle-o fa-stack-2x"></i>' +
      '<strong class="fa-stack-1x"><span id="bjjt_image_num_fa">' + parseInt( current_image + 1 ) +
      '</span></strong>' +
      '</span>';
    $( '#img_text_fa_imgnum' ).empty();
    $( '#img_text_fa_imgnum' ).append( txt );
  } else {
    $( '#bjjt_image_class_swapper_right' ).addClass( "bjjt_image_chevron_disabled" );
  }
} );

// Make the image tha same width as the content-panel-tech div
$( '#bjjt_image_img' ).width( $( '.content-panel-tech' ).width() );
