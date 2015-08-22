require 'rails_helper'

describe Address do

  describe "validation" do
    it {should belong_to(:country)}
    it {should validate_presence_of(:address)}
    it {should validate_presence_of(:zipcode)}
    it {should validate_presence_of(:city)}
    it {should validate_presence_of(:phone)}
  end
end