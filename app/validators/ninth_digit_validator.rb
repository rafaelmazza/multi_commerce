class NinthDigitValidator < ActiveModel::EachValidator
  def validate_each(record, attr_name, value)
    if record[:phone_code] == '11' and value =~ /^(5[2-9]|6[0-9]|7[01234569]|8[0-9]|9[0-9]).+/ and value.length != 9
      record.errors.add(attr_name, I18n.t('errors.messages.ninth_digit'))
    end
  end
end

# This allows us to assign the validator in the model
module ActiveModel::Validations::HelperMethods
  def validates_ninth_digit(*attr_names)
    validates_with NinthDigitValidator, _merge_attributes(attr_names)
  end
end