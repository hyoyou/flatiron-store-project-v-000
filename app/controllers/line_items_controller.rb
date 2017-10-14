class LineItemsController < ApplicationController

  def create
    raise params.inspect
    @cart = Cart.find_by(user_id: current_user.id)
    if @cart.nil?
      @cart = current_user.carts.build(user_id: current_user.id)
    end
    current_user.current_cart = @cart

    #item = Item.find_by(id: params[:item_id])
    #@cart.items << item
    @cart.add_item(params[:item_id])
    current_user.save

    redirect_to cart_path(@cart)
  end
end
