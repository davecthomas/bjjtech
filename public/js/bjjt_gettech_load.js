$( document ).ready( function() {
  const maxlenSearchStrDisplayed = 6;
  if ( searchStr.length > 0 ) {
    var searchStringTrunc;
    if ( searchStr.length > maxlenSearchStrDisplayed ) {
      searchStr = searchStr.slice( 0, maxlenSearchStrDisplayed ) + "...";
    }
    $( '#return_to_search' ).html(
      '<i class="fa fa-arrow-left" aria-hidden="true"></i>&nbsp;' +
      searchStr + '&nbsp;<i class="fa fa-search" aria-hidden="true">' );
    $( '#return_to_search_parent' ).show();
    $( '[data-toggle="tooltip"]' ).tooltip();
  }

} );

$( document ).on( 'click', '#return_to_search', function() {
  window.location = root_url + "tech/text/" + searchStr;
} );
