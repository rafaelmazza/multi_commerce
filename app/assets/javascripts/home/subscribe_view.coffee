jQuery ->
  class SubscribeView extends Backbone.View
  	el: $ 'body'
	
  	initialize: ->
  		# _.bindAll @, 'searchAddress'
  		new ButtonGroupView
	
  	events:
  		"keyup #zipcode": "searchAddress"
	
  	searchAddress: ->
  		zipcode = this.$('#zipcode').val()
  		if (zipcode.match(/^\d{5}-?\d{3}$/))
  			$.get('/addresses/' + zipcode, (response) ->
  				console.log(response)
  				if (response['error'])
  					alert(response['error'])
  				else
  					$('#street').val(response.street).change()
  					$('#district').val(response.district).change()
  					$('#city').val(response.city).change()
  					$('#state').val(response.state).change()
  			)
	
  class ButtonGroupView extends Backbone.View
    el: $ '.btn-group'
    
    initialize: ->
      @form = this.$el.parents('form').eq(0)
      @name = this.$el.attr('data-toggle-name');
      @hidden = $('input[name="' + @name + '"]', @form);
      console.log(@name)
      
    events:
      "click button": "updateTimetable"

    updateTimetable: (e) ->
      timetableID = e.target.value
      @hidden.val(timetableID)
      voucherID = $('#voucher_id').val()
      $.post('/vouchers/' + voucherID, {_method: 'PUT', voucher: {timetable_id: timetableID}}, (response) ->
        console.log(response)
      )
      
  new SubscribeView
  # new ButtonGroupView