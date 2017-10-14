class LineItemsController < ApplicationController

  def create
    @cart = Cart.find_by(user_id: current_user.id)
    if @cart.nil?
      @cart = current_user.carts.build(user_id: current_user.id)
    end
    current_user.current_cart = @cart

    @cart.add_item(params[:item_id]).save
    current_user.save

    redirect_to cart_path(@cart)
  end

end
