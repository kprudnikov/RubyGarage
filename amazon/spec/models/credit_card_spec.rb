require "rails_helper"

describe CreditCard do
  
  describe 'validation' do
    it { should validate_length_of(:cvv).is_equal_to(3)}
    it { should allow_value("123").for(:cvv) }
    it { should allow_value("000").for(:cvv) }
    it { should_not allow_value("2a2").for(:cvv) }
    it { should validate_length_of(:number).is_equal_to(16) }
    it { should validate_inclusion_of(:exp_month).in_range(1..12) }
    it { should validate_presence_of(:firstname) }
    it { should validate_presence_of(:lastname) }
    it { should validate_numericality_of(:exp_year).is_greater_than_or_equal_to(Time.now.year) }
  end
end