function replaceAll( str, search, replacement ) {
  return str.replace( new RegExp( search, 'g' ), replacement );
};

function replaceAllNumlist( str, replacement ) {
  re = new RegExp( /\d+(\.)/, 'g' );
  return str.replace( re, replacement );
};

// function breakBeforeNum(
//   {[0-9]+.}
// )
function insertAt( src, index, str ) {
  return src.substr( 0, index ) + str + src.substr( index )
}


function isNumeric( n ) {
  return !isNaN( parseFloat( n ) ) && isFinite( n );
};
