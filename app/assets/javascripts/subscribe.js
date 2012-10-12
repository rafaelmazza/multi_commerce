$(document).ready(function () {
	// $('#credit-card').css('display', 'none');
	
	$('#lead_address_attributes_zipcode').keyup(function () {
		var zipcode = $(this).val()
		if (zipcode.match(/^\d{5}-?\d{3}$/)) {
			$.get('/addresses/' + zipcode, function (response) {
				console.log(response);
				if (response['error']) {
					alert(response['error']);
				} else {
					$('#lead_address_attributes_street').val(response.street).change();
					$('#lead_address_attributes_district').val(response.district).change();
					$('#lead_address_attributes_city').val(response.city).change();
					$('#lead_address_attributes_state').val(response.state).change();
				}
			})
		}
	});
	
	$('input:radio.payment_method').change(function () {
		if ($(this).hasClass('credit-card')) {
			// $('#credit-card').css('display', 'inline');
		} else {
			// $('#credit-card').css('display', 'none');
		}
		$.post('/vouchers/43/update_payment_method', {payment_method: $(this).val()}, function (response) {
			// $('form').resetClientSideValidations();
			console.log(response);
		});
	})
});