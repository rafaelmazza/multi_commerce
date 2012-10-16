$(document).ready(function () {
	// $('#credit-card').css('display', 'none');
	
	$('#voucher_address_attributes_zipcode').keyup(function () {
		var zipcode = $(this).val()
		if (zipcode.match(/^\d{5}-?\d{3}$/)) {
			$.get('/addresses/' + zipcode, function (response) {
				console.log(response);
				if (response['error']) {
					alert(response['error']);
				} else {
					$('#voucher_address_attributes_street').val(response.street).change();
					$('#voucher_address_attributes_district').val(response.district).change();
					$('#voucher_address_attributes_city').val(response.city).change();
					$('#voucher_address_attributes_state').val(response.state).change();
				}
			})
		}
	});

	$('input:radio.credit-card').change(function () {
		var paymentMethod = this.value;
		var amount = $('#voucher_total').val();
		// console.log(voucherTotal);
		// var url = 'https://www.akatus.com/api/v1/parcelamento/simulacao.json?email=akatus@cafeazul.com.br&amount=' + amount + '&payment_method=' + paymentMethod + '&api_key=6494F2BA-CDEA-487A-9633-3B2CBFCA47F6'
		var url = '/installments.json';
		// $.getJSON(url, function (response) {
		// 	console.log(response);
		// });
		$.ajax({
		  url: url,
		  data: {amount: amount, payment_method: paymentMethod},
		  success: function (context) {
				// console.log(response);
				// console.log(url);
				// var context = jQuery.parseJSON('{"resposta":{"descricao":"1,99% ao m\u00eas","parcelas_assumidas":0,"parcelas":[{"quantidade":1,"valor":"100.0","total":"100.0"},{"quantidade":2,"valor":"51.5","total":"102.99"},{"quantidade":3,"valor":"34.67","total":"104.0"},{"quantidade":4,"valor":"26.26","total":"105.02"},{"quantidade":5,"valor":"21.21","total":"106.04"},{"quantidade":6,"valor":"17.85","total":"107.07"},{"quantidade":7,"valor":"15.45","total":"108.11"},{"quantidade":8,"valor":"13.65","total":"109.16"},{"quantidade":9,"valor":"12.25","total":"110.21"},{"quantidade":10,"valor":"11.13","total":"111.26"},{"quantidade":11,"valor":"10.22","total":"112.33"},{"quantidade":12,"valor":"9.45","total":"113.4"}]}}');
				console.log(context);
				var source = $("#installments-options").html();
				// console.log(source);
				var template = Handlebars.compile(source);
				var html = template(context["resposta"]);
				// console.log(html);
				$('#installments-placeholder').html(html);
			},
		  dataType: 'json'
		});
	})
	
	// $('input:radio.payment_method').change(function () {
	// 	if ($(this).hasClass('credit-card')) {
	// 		// $('#credit-card').css('display', 'inline');
	// 	} else {
	// 		// $('#credit-card').css('display', 'none');
	// 	}
	// 	var voucher_id = $('#voucher_id').val();
	// 	console.log(voucher_id);
	// 	// $.post('/vouchers/' + voucher_id + '/update_payment_method', {payment_method: $(this).val()}, function (response) {
	// 	$.post('/vouchers/' + voucher_id, {_method: 'PUT', voucher: {payment_method: $(this).val()}}, function (response) {
	// 		// $('form').resetClientSideValidations();
	// 		console.log(response);
	// 	}, 'json');
	// })
	
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