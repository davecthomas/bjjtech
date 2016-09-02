// Load the IFrame Player API code asynchronously.
var tag = document.createElement( 'script' );
tag.src = "http://www.youtube.com/player_api";
var firstScriptTag = document.getElementsByTagName( 'script' )[ 0 ];
firstScriptTag.parentNode.insertBefore( tag, firstScriptTag );

// Replace the 'ytplayer' element with an <iframe> and
// YouTube player after the API code downloads.
var player;

function onYouTubePlayerAPIReady() {
  player = new YT.Player( 'ytplayer', {
    height: '390',
    width: $( '.content-panel-tech' ).width(),
    videoId: '<%- tech_detail.videoid %>'
  } );
}
