function replaceAll( str, search, replacement ) {
  return str.replace( new RegExp( search, 'g' ), replacement );
};

function replaceAllNumlist( str, replacement ) {
  re = new RegExp( /\d+(\.)/g );
  return str.replace( re, replacement );
};

function cleanDetailText( detailIn ) {
  var details = replaceAllNumlist( detailIn,
    '<br><br><i class="fa fa-chevron-circle-right"></i>&nbsp;' );
  details = replaceAll( details, "\n", "" );
  if ( details.indexOf( '<br><br>' ) == 0 ) {
    details = details.replace( '<br><br>', '' );
  }
  return details;
}

function fixQuotes( str ) {
  return str.replace( /'/g, '&rsquo;' );
}

function escapeQuotes( str ) {
  return str.replace( /(['"])/g, "\\$1" );
}

function insertAt( src, index, str ) {
  return src.substr( 0, index ) + str + src.substr( index )
}


function isNumeric( n ) {
  return !isNaN( parseFloat( n ) ) && isFinite( n );
};
