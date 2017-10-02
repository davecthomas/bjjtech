$( document ).ready( function() {

  var type = 0,
      topic = 0,
      level = 0,
      sport = 0,
      position = 0;

  function toggleShow( section){
    $('#'+section+'-expand-section').css('display','inline');
    $( '#'+section+'-chevron-toggle' ).removeClass( 'fa-chevron-down' );
    $( '#'+section+'-chevron-toggle' ).addClass( 'fa-chevron-up' );
  }

  function toggleHide( section){
    $('#'+section+'-expand-section').css('display','none');
    $( '#'+section+'-chevron-toggle' ).removeClass( 'fa-chevron-up' );
    $( '#'+section+'-chevron-toggle' ).addClass( 'fa-chevron-down' );
  }

  function toggleSection( section){
    if ($('#'+section+'-expand-section').css('display') == 'none'){
      toggleShow(section);
    } else {
      toggleHide(section);
    }
  }

  // This section of code supports tracking what is selected in lists
  $( document ).on( 'click', '.new_tech_type', function() {
    section = 'type';
    if (type != 0){
      $( '#'+section+type ).removeClass( 'active' );
    }
    type = $( this ).attr( 'data-id' );
    $( '#'+section+type ).addClass( 'active' );

    // This puts the current selection text next to the expand chevron
    $( '#'+section+'-selected').text( $('#'+section+type ).text());
    toggleHide(section);
  });

  $( document ).on( 'click', '.new_tech_topic', function() {
    section = 'topic';
    if (topic != 0){
      $( '#'+section+topic ).removeClass( 'active' );
    }
    topic = $( this ).attr( 'data-id' );
    $( '#'+section+topic ).addClass( 'active' );

    // This puts the current selection text next to the expand chevron
    $( '#'+section+'-selected').text( $('#'+section+topic ).text());
    toggleHide(section);
  });

  $( document ).on( 'click', '.new_tech_level', function() {
    section = 'level';
    if (level != 0){
      $( '#'+section+level ).removeClass( 'active' );
    }
    level = $( this ).attr( 'data-id' );
    $( '#'+section+level ).addClass( 'active' );

    // This puts the current selection text next to the expand chevron
    $( '#'+section+'-selected').text( $('#'+section+level ).text());
    toggleHide(section);
  });

  $( document ).on( 'click', '.new_tech_sport', function() {
    section = 'sport';
    if (sport != 0){
      $( '#'+section+sport ).removeClass( 'active' );
    }
    sport = $( this ).attr( 'data-id' );
    $( '#'+section+sport ).addClass( 'active' );

    // This puts the current selection text next to the expand chevron
    $( '#'+section+'-selected').text( $('#'+section+sport ).text());
    toggleHide(section);
  });

  $( document ).on( 'click', '.new_tech_position', function() {
    section = 'position';
    if (position != 0){
      $( '#'+section+position ).removeClass( 'active' );
    }
    position = $( this ).attr( 'data-id' );
    $( '#'+section+position ).addClass( 'active' );

    // This puts the current selection text next to the expand chevron
    $( '#'+section+'-selected').text( $('#'+section+position ).text());
    toggleHide(section);
  });

  // This section of code supports expand and contract of chevron in list-style-type
  $( document ).on( 'click', '#type-chevron', function() {
    toggleSection('type');
  });

  $( document ).on( 'click', '#topic-chevron', function() {
    toggleSection('topic');
  });

  $( document ).on( 'click', '#level-chevron', function() {
    toggleSection('level');
  });

  $( document ).on( 'click', '#sport-chevron', function() {
    toggleSection('sport');
  });

  $( document ).on( 'click', '#position-chevron', function() {
    toggleSection('position');
  });

  // Save the technique
  $( document ).on( 'click', '#newtech', function() {
    var newdata = {
      name: $('#name').val(),
      setup: $('#setup').val(),
      details: $('#details').val(),
      credit: $('#credit').val(),
      type: type,
      topic: topic,
      sport: sport,
      skilllevel: level,
      startingpos: position,
      twofactor: $('#twofactor').val()
    };

    $.ajax( {
      type: "POST",
      url: api_url + "tech/new/",
      data: newdata,
      success: function( result ) {
          if ( result.status === 'success' ) {
          //  $( '#newtech' ).attr( 'data-id', result.data );
            window.location = root_url + "tech/" + result.data;
          } else {
            alert( result.message)
          }
        }
    } );

    return false;
  } );


} );
