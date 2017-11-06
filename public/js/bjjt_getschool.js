$(document).ready(function() {
  var courseid = 0;

  // This section of code supports expand and contract of chevron in list-style-type
  $(document).on('click', '#courses-chevron', function() {
    toggleSection('courses');
  });

  // Show the courses in school
  $(document).on('click', '.get_course', function() {

    section = 'courses';
    if (courseid != 0) {
      $('#' + section + courseid).removeClass('active');
    }
    courseid = $(this).attr('data-id');
    $('#' + section + courseid).addClass('active');
    window.location = root_url + "course/" + courseid;
  });

  // Add a class to the course
  $(document).on('click', '.new_school_course', function() {
    schoolid = $(this).attr('data-id');
    // TO DO: figure out how to make optional parameers in a route, so we can call technew/:classid without requiring it always
    window.location = root_url + "technew/";
  });

  // redundant - already here, but do it anyway (this is unnecessary)
  $(document).on('click', '.get_school', function() {
    schoolid = $(this).attr('data-id');
    // TO DO: figure out how to make optional parameers in a route, so we can call technew/:classid without requiring it always
    window.location = root_url + "school/" + schoolid;
  });
});
