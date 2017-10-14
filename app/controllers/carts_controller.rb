class CartsController < ApplicationController

  def show
    @current_cart = Cart.find_by(id: params[:id])
  end

  def checkout
    @current_cart = Cart.find_by(id: params[:id])
    @current_cart.checkout
    redirect_to cart_path(@current_cart)
  end

end
