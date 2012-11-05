jQuery ->
  class SubscribeView extends Backbone.View
  	el: $ 'body'
	
  	initialize: ->
  		# _.bindAll @, 'searchAddress'
  		$('#voucher_cpf').mask("999.999.999-99")
  		$('#zipcode').mask("99999-999")
  		$('#expiration_date').mask("99/9999")
  		new ButtonGroupView
	
  	events:
  		"keyup #zipcode": "searchAddress"
	
  	searchAddress: ->
  		zipcode = this.$('#zipcode').val()
  		if (zipcode.match(/^\d{5}-\d{3}$/))
  		  $('#loading').remove()
  		  $('#zipcode').parents('li').append('<img id="loading" src="/assets/application/loading.gif"/>')
  		  $('#street, #district, #city').attr('placeholder', 'Buscando rua...')
  		  $.get('/addresses/' + zipcode, (response) ->
		      $('#street, #district, #city').attr('placeholder', '')
		      $('#street').val(response.street).change()
    		  $('#district').val(response.district).change()
    		  $('#city').val(response.city).change()
    		  $('#state').val(response.state).change()
      		$('#loading').remove()
  		  )
	
  class ButtonGroupView extends Backbone.View
    el: $ '.btn-group'
    
    initialize: ->
      @form = this.$el.parents('form').eq(0)
      @name = this.$el.attr('data-toggle-name');
      @hidden = $('input[name="' + @name + '"]', @form)
      
    events:
      "click button": "updateTimetable"
      "hover button": "hover"

    updateTimetable: (e) ->
      timetableID = e.target.value
      @hidden.val(timetableID)
      voucherID = $('#voucher_id').val()
      $.post('/vouchers/' + voucherID + '.json', {_method: 'PUT', voucher: {timetable_id: timetableID}}, (response) ->
        console.log(response)
        $('.timetable-button').removeClass('btn-secondary-selected')
        $(e.target).addClass('btn-secondary-selected')
      )
    
    hover: (e) ->
      $('timetable-button').toggleClass('.btn-secondary-selected')
      
  new SubscribeView