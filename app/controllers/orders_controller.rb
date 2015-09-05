class OrdersController < ApplicationController
  def index
    @pending_order=Order.where(:customers_id=>session[:user_id]).where(:date=>nil).first
    if @pending_order
      if @pending_order.lines.size<1
        @pending_order=nil
      end
    end
    @orders=Order.paginate(:page => params[:page]).where(:customers_id=>session[:user_id]).where("orders.date IS NOT NULL").sort_by { |order| order.date}
  end

  def new
    @order=Order.where(:date=>nil).where(:customers_id=>session[:user_id]).first
    if(!@order || @order.lines.size<1)
      flash[:notice] = "You Have No Orders To Place"
      redirect_to products_path
    end
  end
  def show
    @order=Order.find(params[:id])
  end


  def create

  end

  private

  def order_params
    params.require(:order).permit()
  end

end
