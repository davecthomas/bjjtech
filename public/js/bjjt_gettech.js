$(document).ready(function() {

  function toggleShow(section) {
    $('#' + section + '-expand-section').css('display', 'inline');

  }

  function toggleHide(section) {
    $('#' + section + '-expand-section').css('display', 'none');

  }

  function toggleSection(section, listResults) {
    if ($('#' + section + '-expand-section').css('display') == 'none') {
      var numlist = listResults.length;
      var html = "";
      var id, name, tag;
      if (numlist > 0) {
        for (i = 0; i < numlist; i++) {
          if (section == "related") {
            id = listResults[i].techid;
            name = listResults[i].techname;
            tag = "relatedtechnique";
          } else {
            id = listResults[i].classid;
            name = listResults[i].classname + " at " + listResults[i].schoolname;
            tag = "classesincluding";
          }

          html += '<a href="#" class="list-group-item select-group-item ' + section + '-group-item" id="' +
            id + '" data-listindex="' + i + '" data-id="' + id + '" data-tag="' + tag + '">' + name + '</a>';
        }
        $("#" + section + "-expand-section").html(html);
      }
      toggleShow(section);
    } else {
      toggleHide(section);
    }
  }

  $(document).on('click', '.related-group-item', function() {
    var id = $(this).attr('data-id');
    window.location = root_url + "tech/" + id;
  });

  $(document).on('click', '.classes-group-item', function() {
    var id = $(this).attr('data-id');
    window.location = root_url + "class/" + id;
  });


  // Get related techniques
  $(document).on('click', '#getTechRelated', function() {
    var id = $('#getTechRelated').attr('data-id');

    $.ajax({
      url: api_url + "tech/related/" + id,
      success: function(result) {
        if (result.status === 'success') {;
          toggleSection('related', result.data);

        } else {
          alert(result.message)
        }
      }
    });

    return false;
  });

  // Get classes with technique
  $(document).on('click', '#getAllClassesWithTech', function() {
    var id = $('#getAllClassesWithTech').attr('data-id');

    $.ajax({
      url: api_url + "classestech/" + id + "/1", // TO DO - hardwired schoolid 1 here. Get from session???
      success: function(result) {
        if (result.status === 'success') {;
          toggleSection('classes', result.data);

        } else {
          alert(result.message)
        }
      }
    });

    return false;
  });

});
