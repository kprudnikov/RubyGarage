require 'rails_helper'

describe Country do

  describe 'validation' do
    it { should validate_presence_of(:name) }
  end
end