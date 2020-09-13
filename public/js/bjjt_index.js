$( document ).ready( function() {



  var len_topic_list = len;
  $( '[data-toggle="tooltip"]' ).tooltip();


  //
  $( document ).on( 'click', '.get_techs_topic', function() {
    // Hide the nudge
    $( "#nudge_topic" ).hide();
    // $("#detail-content-panel").hide();
    $( "#detail-content-panel" ).removeClass( 'open' );

    var topic_id = $( this ).attr( 'data-id' );
    var tag = $( this ).attr( 'data-tag' );

    $.ajax( {
      url: api_url + "tech/tag/" + tag + "/" + topic_id,
      success: function( result ) {
        // $("#techlist-content-panel").show();
        $( '#techs' ).empty();
        $( '#num_techs' ).empty();
        var techs = result;
        alert(api_url + "tech/tag/" + tag + "/" + topic_id + "; " + techs.status);
        if ( techs.status === 'success' ) {
          $( '#techlist-content-panel' ).addClass( 'open' );
          var len = techs.data.length;
          var video = "";
          alert(len);
          for ( i = 0; i < len; i++ ) {
            if ( i == 0 ) {
              $( '#num_techs' ).append( len + "&nbsp;" + techs.data[ i ].tag_name +
                "&nbsp;" );
              document.title = bjjtech_pagetitle + ": Topic: " + techs.data[ i ].tag_name;
              alert(document.title);
            }
            if ( techs.data[ i ].videoid ) {
              video = '<i class="fa fa-video-camera"></i>&nbsp;';
            } else {
              video = "&emsp;";
            }
            $( '#techs' ).append(
              "<a href='#' class='list-group-item get_tech_detail' id='" + techs.data[
                i ].index + "' data-listindex='" + i + "' data-id='" + techs.data[
                i ].index + "'><h5 class='list-group-item-heading'>" + video +
              techs.data[ i ].name + "</h5></a>" );
          }
          if ( len > 0 ) {
            $( "#nudge_tech" ).show();
          }
        }
      }
      // error: function( jqxhr, str_textStatus,  str_errorThrown){
      //   alert(str_textStatus+ " ; " + str_errorThrown);
      // }
    } );
    return false;
  } );
  $( document ).on( 'click', '#moredetail', function() {
    var id = $( this ).attr( 'data-id' );
    window.location = root_url + "tech/" + id;
  } );

  $( document ).on( 'click', '.get_tech_detail', function() {
    var id = $( this ).attr( 'data-id' );

    $.ajax( {
      url: api_url + "tech/brief/" + id,
      success: function( result ) {
        var tech = result,
          video = "";
        if ( tech.status === 'success' ) {
          $( '#detail_h' ).empty();
          $( '#details' ).empty();
          $( "#nudge_tech" ).hide();
          // $("#detail-content-panel").show();
          $( '#detail-content-panel' ).addClass( 'open' );
          // $("#nudge_detail").show();
          $( '#detail_h' ).append( tech.data.name );
          // Swap \n with <br>
          if ( tech.data.details ) {
            var details = cleanDetailText( tech.data.details );

            details = fixQuotes( details );
            tech.data.name = fixQuotes( tech.data.name );
            if ( tech.data.videoid ) {
              video =
                '<button id="moredetail" data-id="initiallyundefined" name="moredetail" class="btn btn-outline-primary bjjt_button" data-toggle="tooltip" title="See video plus more on ' +
                tech.data.name +
                '"><i class="fa fa-video-camera"></i>&nbsp;Tap for detail&nbsp;<i class="fa fa-expand" aria-hidden="true"></i></button>';
            } else {
              video =
                '<button id="moredetail" data-id="initiallyundefined" name="moredetail" class="btn btn-outline-primary bjjt_button" data-toggle="tooltip" title="More on ' +
                tech.data.name +
                '">Tap for detail&nbsp;<i class="fa fa-expand" aria-hidden="true"></i></button>';
            }
            $( '#moredetail' ).replaceWith( video );

            document.title = bjjtech_pagetitle + ": " + tech.data.name;

          } else {
            var details = "Sorry, homie, I haven't written this yet.";
          }
          $( '#moredetail' ).attr( 'data-id', tech.data.index );
          $( '#details' ).append( "<h4>Set Up</h4><p>" + tech.data.setup +
            "</p><h4>Details</h4><p>" + details + "</p>" );
        }
      }
    } );
    return false;
  } );

} );
