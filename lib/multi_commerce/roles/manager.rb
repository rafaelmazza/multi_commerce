module Roles
  module Manager
    def self.included(base)
      # base.extend ClassMethods
      base.has_many :leads, through: :franchises
      base.has_many :vouchers, through: :franchises
      base.has_many :unities, through: :franchises
    end

    # module ClassMethods
    # end
  end
end
