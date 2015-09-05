class LinesController < ApplicationController
  respond_to :js
  def new
    @line = Line.new({:product_id=>params[:product_id]})
  end

  def create
    @order=Order.where(:date => nil).where(:customers_id=>session[:user_id]).first
    if !@order
      @order=Order.new
      @order.customers_id=session[:user_id]
      if @order.save
        @order.order_no="O-%.6d" % @order.id
        @order.save
      end
    end
    @line  = Line.new(line_params)
    @line.unit_price=Product.find(@line.product_id).price
    @line.total_price=@line.unit_price*@line.qty
    @line.order_id=@order.id
    if @line.save
      @order.total+=@line.total_price
      @order.save
    else
      render('new')
    end

  end
  def edit
    @line=Line.find(params[:id])
  end
  def update
    @line=Line.find(params[:id])
    unit_price=@line.unit_price
    old_total_price=@line.total_price
    @order=@line.order
    if @line.update_attributes({qty:line_params[:qty].to_i,total_price:unit_price*line_params[:qty].to_i})
      new_total_price=@line.total_price
      new_total=@order.total-old_total_price+new_total_price
      @order.update_attributes({total:new_total})
      redirect_to(orders_path)
    else
      render('edit')
    end
  end

  def destroy
    @line=Line.find(params[:id])
    @order=@line.order
    new_total=@order.total-@line.total_price
    @order.update_attributes({total:new_total})
    @line.destroy
    redirect_to(orders_path)
  end

  private

  def line_params
    params.require(:line).permit(:qty,:product_id)
  end
end
