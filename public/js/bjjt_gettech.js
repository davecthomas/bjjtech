

$( document ).ready( function() {

  function toggleShow( section){
    $('#'+section+'-expand-section').css('display','inline');

  }

  function toggleHide( section){
    $('#'+section+'-expand-section').css('display','none');

  }

  function toggleSection( section, relateds){
    if ($('#'+section+'-expand-section').css('display') == 'none'){
      var numrelateds = relateds.length;
      var relatedlist = "";
      if (numrelateds > 0){
        for(i = 0; i < numrelateds; i++){
          relatedlist += `<a href="#" class="list-group-item select-group-item related-group-item" id="`+relateds[i].related+`" data-listindex="`+i+`" data-id="`+relateds[i].related+`" data-tag="relatedtechnique">`+relateds[i].name+`</a>`;
        }
        $("#related-expand-section").html(relatedlist);
      }
      toggleShow(section);
    } else {
      toggleHide(section);
    }
  }

  $( document ).on( 'click', '.related-group-item', function() {
    var id = $( this ).attr( 'data-id' );
    window.location = root_url + "tech/" + id;
  } );

  // Get related techniques
  $( document ).on( 'click', '#getTechRelated', function() {
    var id = $( '#getTechRelated' ).attr( 'data-id');

    $.ajax( {
      url: api_url + "tech/related/"+id,
      success: function( result ) {
          if ( result.status === 'success' ) {;
            toggleSection('related', result.data);

          } else {
            alert( result.message)
          }
        }
    } );

    return false;
  } );

} );
