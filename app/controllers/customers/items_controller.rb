class Customers::ItemsController < ApplicationController
	def index
		@items = Item.where(is_active: true).order(name: "ASC")
		@genres = ItemGenre.where(is_delete: false)
	end

	def show
		@item = Item.find(params[:id])
		@genres = ItemGenre.where(is_delete: false)
		unless  customer_signed_in?
      @cart_item = CartItem.new
    else
      @cart_item = current_customer.cart_items.new
    end
	end

	def genres										#最終的にはAjax化したい…
		@items = Item.where(item_genre_id: params[:genres_id]).order(name: "ASC")
	    @genre = ItemGenre.find(params[:genres_id])
		@genres = ItemGenre.where(is_delete: false)
	end

  private
    def item_params
      params.require(:item).permit(:image, :name, :description, :item_genre_id, :price, :is_active)
		end
end