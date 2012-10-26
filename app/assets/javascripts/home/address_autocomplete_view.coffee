$ ->
  class AddressAutocompleteView extends Backbone.View
    RETURN_KEY_CODE: 13
    
    el: $ '#lead_address_search'
    
    defaults: {
      types: ['geocode']
      componentRestrictions: {country: 'br'}
    }
    
    initialize: (options) ->
      @options = _.extend(@defaults, options)
      @autocomplete = new google.maps.places.Autocomplete(@el, @options);
      @geocoder = new google.maps.Geocoder()
      
    events: {
      "keydown": "keyDown"
    }
    
    keyDown: (e) ->
      that = @
      if (e.keyCode == this.RETURN_KEY_CODE)
        @geocoder.geocode({ 'address': @el.value }, (results, status) ->
          if (status == google.maps.GeocoderStatus.OK)
            # console.log(results)
            $('#lead_latitude').val(results[0].geometry.location.Ya)
            $('#lead_longitude').val(results[0].geometry.location.Za)
            that.$el.change()
        )
        e.preventDefault()

  new AddressAutocompleteView if $('.autocomplete').length > 0