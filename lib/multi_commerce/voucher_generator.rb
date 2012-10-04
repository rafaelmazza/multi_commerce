class MultiCommerce::VoucherGenerator
  def self.generate
    (0...16).collect { chars[Kernel.rand(chars.length)] }.join
  end

  private

  def self.chars
    ('a'..'z').to_a + ('A'..'Z').to_a
  end
end