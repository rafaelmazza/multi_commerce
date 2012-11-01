(function() {

  ClientSideValidations.formBuilders['Formtastic::FormBuilder'] = {
    add: function(element, settings, message) {
      var errorElement, wrapper;
      if (element.data('valid') !== false) {
        wrapper = element.closest('li');
        errorElement = $('<div/>', {
          "class": settings.inline_error_class,
          text: message
        });
        wrapper.addClass('error');
        return wrapper.prepend(errorElement);
      } else {
        return element.parent().find("p." + settings.inline_error_class).text(message);
      }
    },
    remove: function(element, settings) {
      var errorElement, wrapper;
      wrapper = element.closest('li.error');
      errorElement = wrapper.find("p." + settings.inline_error_class);
      wrapper.removeClass('error');
      return errorElement.remove();
    }
  };

}).call(this);
