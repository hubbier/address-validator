class AddressesController < ApplicationController
  def index
    @address = Address.new
    @address.front_end = true
    render 'new'
  end

  def new; end

  def create
    @address = Address.new(address_params)
    if @address.save
      render json: { msg: "Address saved!" }, status: :ok
    else
      render json: @address.errors.full_messages.to_json, status: :not_found
    end
  end

  private

  def address_params
    params.permit(:street_address, :city, :state, :zip_code)
  end
end
