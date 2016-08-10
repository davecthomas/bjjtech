module.exports = {

  replaceAll: function( str, search, replacement ) {
    return str.replace( new RegExp( search, 'g' ), replacement );
  },

  isNumeric: function( n ) {
    return !isNaN( parseFloat( n ) ) && isFinite( n );
  }

};
