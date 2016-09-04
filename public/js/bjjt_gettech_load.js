$( document ).ready( function() {
  if ( searchStr.length > 0 ) {
    $( '#return_to_search' ).html(
      '<i class="fa fa-arrow-left" aria-hidden="true"></i>&nbsp;' +
      searchStr + '&nbsp;Search' );
    $( '#return_to_search_parent' ).show();
  }

} );

$( document ).on( 'click', '#return_to_search', function() {
  window.location = root_url + "tech/text/" + searchStr;
} );
