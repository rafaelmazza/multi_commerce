$(document).ready(function () {
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
});