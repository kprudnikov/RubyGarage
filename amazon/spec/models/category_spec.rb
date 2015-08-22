require 'rails_helper'

describe Category do

  describe "validation" do
    it { should have_many(:books) }
    it { should validate_presence_of(:title) }
    it { should validate_uniqueness_of(:title) }
  end
end