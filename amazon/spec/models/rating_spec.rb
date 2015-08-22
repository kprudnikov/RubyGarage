require 'rails_helper'

describe Rating do
  describe 'validation' do
    it { should belong_to(:customer) }
    it { should belong_to(:book) }
    it { should validate_inclusion_of(:rating).in_range(1..10) }
  end
end