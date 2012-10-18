jQuery ->
	class SubscribeView extends Backbone.View
		el: $ 'body'
		
		initialize: ->
			# _.bindAll @, 'searchAddress'
		
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
						$('#street').val(response.street).change();
						$('#district').val(response.district).change();
						$('#city').val(response.city).change();
						$('#state').val(response.state).change();
				)
		
	new SubscribeView