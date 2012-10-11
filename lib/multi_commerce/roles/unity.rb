module Roles
  module Unity
    def self.included(base)
      # base.extend ClassMethods
      base.has_many :leads, through: :unities
    end

    # module ClassMethods
    # end
  end
end
