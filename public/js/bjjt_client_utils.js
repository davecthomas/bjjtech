function replaceAll( str, search, replacement ) {
  return str.replace( new RegExp( search, 'g' ), replacement );
};

function isNumeric( n ) {
  return !isNaN( parseFloat( n ) ) && isFinite( n );
};
