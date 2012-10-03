function initialize() {
  var input = document.getElementById('address-search-field');
  var options = {
    types: ['geocode'],
    componentRestrictions: {country: 'br'}
  };
  var autocomplete = new google.maps.places.Autocomplete(input, options);

  google.maps.event.addDomListener(input, 'keydown', function(e) {
    if (e.keyCode == 13) { // hits enter
      var geocoder = new google.maps.Geocoder();
      geocoder.geocode({ 'address': input.value }, function(results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
          console.log(results);
          console.log(results[0].geometry.location.Xa);
          console.log(results[0].geometry.location.Ya);
					// $('#address_coordinates_latitude').val(results[0].geometry.location.Xa)
					// $('#address_coordinates_longitude').val(results[0].geometry.location.Ya)
        }
      });

      e.preventDefault();
    } 
  });

}
google.maps.event.addDomListener(window, 'load', initialize);