$(document).ready(function() {
  var classid = 0;

  // This section of code supports expand and contract of chevron in list-style-type
  $(document).on('click', '#classes-chevron', function() {
    toggleSection('classes');
  });

  // Show the school
  $(document).on('click', '.get_school', function() {
    window.location = root_url + "school/" + $(this).attr('data-id');;
  });

  // Show the program
  $(document).on('click', '.get_course', function() {
    window.location = root_url + "course/" + $(this).attr('data-id');;
  });

  // Show the classes in course
  $(document).on('click', '.get_class', function() {

    section = 'classes';
    if (classid != 0) {
      $('#' + section + classid).removeClass('active');
    }
    classid = $(this).attr('data-id');
    $('#' + section + classid).addClass('active');
    window.location = root_url + "class/" + classid;
  });

  // Add a class to the course
  $(document).on('click', '.new_course_class', function() {
    courseid = $(this).attr('data-id');
    // TO DO: figure out how to make optional parameers in a route, so we can call technew/:classid without requiring it always
    window.location = root_url + "technew/";
  });

});
