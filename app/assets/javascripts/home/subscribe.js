$(document).ready(function () {
  $('#credit-card, #installments-placeholder').css('display', 'none');

	$('input:radio.credit-card').change(function () {
	  $('#credit-card, #installments-placeholder').css('display', 'inline');
		var paymentMethod = this.value;
		var amount = $('#voucher_total').val();
		var url = '/installments.json';

		$.ajax({
		  url: url,
		  data: {amount: amount, payment_method: paymentMethod},
		  success: function (context) {
				var source = $("#installments-options").html();
				var template = Handlebars.compile(source);
				var html = template(context["resposta"]);
				$('#installments-placeholder').html(html);
			},
		  dataType: 'json'
		});
	});
	
	$('input:radio.boleto').change(function () {
	  $('#credit-card, #installments-placeholder').css('display', 'none');
	});

});