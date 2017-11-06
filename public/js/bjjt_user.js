$(document).ready(function() {
  $(document).on('click', '#logout', function() {
    // to do: clear session storage also???
    localStorage.clear();

    // to do: url encode the root_url and add it to the
    // Allowed Logout urls at https://manage.auth0.com/#/tenant/advanced
    window.location = "https://app54706413.auth0.com/v2/logout?returnTo=" + root_url;
    return false;
  });

});
