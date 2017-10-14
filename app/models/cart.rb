class Cart < ActiveRecord::Base
  has_many :line_items
  has_many :items, through: :line_items
  belongs_to :user

  def total
    total = 0
    self.line_items.each do |line_item|
      total += (line_item.quantity * line_item.item.price)
    end
    total
  end

  def add_item(item_id)
    @item = Item.find(item_id)
    line_item = self.line_items.find_by(item_id: @item.id)
    if line_item
      line_item.quantity += 1
    else
      line_item = self.line_items.build(cart_id: self.id, item_id: @item.id)
    end
    line_item
  end

  def checkout
    self.line_items.each do |line_item|
      line_item.item.inventory -= line_item.quantity
      line_item.item.save
    end

    self.status = "submitted"
    self.save
    self.destroy
  end

end
