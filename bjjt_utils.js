module.exports = {

  replaceAll: function( str, search, replacement ) {
    return str.replace( new RegExp( search, 'g' ), replacement );
  },

  isNumeric: function( n ) {
    return !isNaN( parseFloat( n ) ) && isFinite( n );
  },


  replaceAllNumlist: function( str, replacement ) {
    re = new RegExp( /\d+(\.)/g );
    return str.replace( re, replacement );
  },

  cleanDetailText: function( detailIn ) {
    var details = replaceAllNumlist( detailIn,
      '<br><br><i class="fa fa-chevron-circle-right"></i>&nbsp;' );
    details = replaceAll( details, "\n", "" );
    if ( details.indexOf( '<br><br>' ) == 0 ) {
      details = details.replace( '<br><br>', '' );
    }
    return details;
  },

  fixQuotes: function( str ) {
    return str.replace( /'/g, '&rsquo;' );
  },

  escapeQuotes: function( str ) {
    return str.replace( /(['"])/g, "\\$1" );
  },

  insertAt: function( src, index, str ) {
    return src.substr( 0, index ) + str + src.substr( index )
  }

};
