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
		var voucher_id = $('#voucher_id').val();
		console.log(voucher_id);
		// $.post('/vouchers/' + voucher_id + '/update_payment_method', {payment_method: $(this).val()}, function (response) {
		$.post('/vouchers/' + voucher_id, {_method: 'PUT', voucher: {payment_method: $(this).val()}}, function (response) {
			// $('form').resetClientSideValidations();
			console.log(response);
		}, 'json');
	})
	
	$('div.btn-group').each(function(){
    var group   = $(this);
    var form    = group.parents('form').eq(0);
    var name    = group.attr('data-toggle-name');
    var hidden  = $('input[name="' + name + '"]', form);
    $('button', group).each(function(){
      var button = $(this);
      button.live('click', function(){
          hidden.val($(this).val());
					console.log($(this).val());
					var voucher_id = $('#voucher_id').val();
					$.post('/vouchers/' + voucher_id, {_method: 'PUT', voucher: {timetable_id: $(this).val()}}, function (response) {
						// $('form').resetClientSideValidations();
						console.log(response);
					});
      });
      if(button.val() == hidden.val()) {
        button.addClass('active');
      }
    });
  });
});