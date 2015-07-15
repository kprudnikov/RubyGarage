class AddressesController < ApplicationController

  def index
    @addresses = Address.all
  end

  def new
    @address = Address.new
    @countries = Country.all
    # puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    # puts params
    # puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
  end

  def create
    Address.create(address_params)
  end

private

  def address_params
    params.require(:address).permit(:address, :zipcode, :city, :phone, :country_id)
  end

end
