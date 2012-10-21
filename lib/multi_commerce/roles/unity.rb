module Roles
  module Unity
    def self.included(base)
      # base.extend ClassMethods
      base.has_many :leads, through: :unities
      base.has_many :vouchers, through: :unities
      base.has_and_belongs_to_many :unities
    end

    # module ClassMethods
    # end
  end
end
