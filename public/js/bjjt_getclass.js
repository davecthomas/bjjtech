$(document).ready(function() {
  var tech = 0;
  // This section of code supports expand and contract of chevron in list-style-type
  $(document).on('click', '#tech-chevron', function() {
    toggleSection('tech');
  });

  // Show the school
  $(document).on('click', '.get_school', function() {
    window.location = root_url + "school/" + $(this).attr('data-id');;
  });

  // Show the program
  $(document).on('click', '.get_class_program', function() {
    window.location = root_url + "course/" + $(this).attr('data-id');;
  });

  // Show the techniques in class
  $(document).on('click', '.get_class_tech', function() {

    section = 'tech';
    if (tech != 0) {
      $('#' + section + tech).removeClass('active');
    }
    techid = $(this).attr('data-id');
    $('#' + section + techid).addClass('active');
    window.location = root_url + "tech/" + techid;
  });

  // Add a tech to the class
  $(document).on('click', '.new_class_tech', function() {
    classid = $(this).attr('data-id');
    // TO DO: figure out how to make optional parameers in a route, so we can call technew/:classid without requiring it always
    window.location = root_url + "technew/";
  });
  // redundant - already here, but do it anyway (this is unnecessary)
  $(document).on('click', '.get_class_class', function() {
    classid = $(this).attr('data-id');
    // TO DO: figure out how to make optional parameers in a route, so we can call technew/:classid without requiring it always
    window.location = root_url + "class/" + classid;
  });

});
