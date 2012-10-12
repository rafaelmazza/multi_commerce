window.ClientSideValidations.validators.local['ninth_digit'] = function(element, options) {
	var phoneAreaCode = $('#lead_phone_code').val();
	if (phoneAreaCode == 11 && /^(5[2-9]|6[0-9]|7[01234569]|8[0-9]|9[0-9]).+/.test(element.val())) {
		if (element.val().length < 9) {
			$(element).attr('maxlength', '9');
			return options.message
		} else {
			$(element).attr('maxlength', '8');
		}
	}
}