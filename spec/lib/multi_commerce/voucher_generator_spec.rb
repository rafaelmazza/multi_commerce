require 'spec_helper'

describe MultiCommerce::VoucherGenerator do
  describe ".generate" do
    it "should not repeat generated code" do
      first = described_class.generate
      second = described_class.generate

      first.should_not == second
    end

    context "the generated code" do
      subject { described_class.generate }

      it "should contain only letters" do
        should match /^[a-zA-Z]*$/
      end

      it "should return a string with 16 caracters" do
        should have(16).items
      end
    end
  end
end
