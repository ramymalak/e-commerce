class ProductsController < ApplicationController
  before_action :confirm_logged_in
  def index
    if request.headers['HTTP_REFERER']=="http://localhost:3001/payments"
      if params[:success]=="true"
        @order=Order.where(:date=>nil).where(:customers_id=>session[:user_id]).first
        @order.date=Date.today
        @order.save
        redirect_to(products_path)
        flash[:notice] = "Payment is accepted."
      elsif params[:success]=="false"
        redirect_to(products_path)
        flash[:notice] = "Payment is rejected.Try again later!"
      end
      #
    end
    @products=Product.paginate(:page => params[:page])
  end
  def new
    if session[:is_admin]==true
      @product=Product.new
    else
      flash[:notice] = "You Have No Access Rights There"
      redirect_to(products_path)
    end
  end
  def create
    if session[:is_admin]==true
    @product=Product.new(product_params)
    if @product.save
      flash[:notice] = "product created successfully."
      redirect_to(products_path)
    else
      # If save fails, redisplay the form so user can fix problems
      render('new')
    end
    else
      flash[:notice] = "You Have No Access Rights There"
      redirect_to(products_path)
    end

  end
  def show
    @product=Product.new
    @product=Product.find(params[:id])
  end
  def edit
    if session[:is_admin]==true
      @product=Product.new
      @product=Product.find(params[:id])
    else
      flash[:notice] = "You Have No Access Rights There"
      redirect_to(products_path)
    end

  end
  def update
    if session[:is_admin]==true
    @product=Product.new
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      flash[:notice] = "Product updated successfully."
      redirect_to(product_path(@product.id))
    else
      render('edit')
    end
    else
      flash[:notice] = "You Have No Access Rights There"
      redirect_to(products_path)
    end

  end
  def destroy
    if session[:is_admin]==true
    @product=Product.new
    @product=Product.find(params[:id])
    if @product.destroy
      flash[:notice] = "Product deleted successfully."
      redirect_to products_path
    else
      redirect_to(products_path)
    end
    else
      flash[:notice] = "You Have No Access Rights There"
      redirect_to(products_path)
    end




  end
  private

  def product_params
    params.require(:product).permit(:name, :description,
                                     :price,:status,:success)
  end
end
