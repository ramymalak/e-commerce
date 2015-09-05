class CustomersController < ApplicationController
  def new
    if session[:user_id]
      redirect_to(products_path)
    else
    @customer= Customer.new
    end
  end

  def create
    @customer = Customer.new(customer_params)
    password_error=0
    @min_pass_length=nil
    if(@customer.password)
      if @customer.password.size<7
        password_error=1
        @min_pass_length="The password must contain minimum 7 characters"
      end
    end
    if @customer.save && password_error==0
      flash[:notice] = 'new customer created.'
      redirect_to(:controller=>'access',:action => 'login')
    else
      render('new')
    end
  end
  def edit
    if params[:id].to_s==session[:user_id].to_s
      @customer=Customer.find(params[:id])
    else
      flash[:notice] = "You Have No Access Rights There"
      redirect_to(products_path)
    end

  end
  def update
    if params[:id].to_s==session[:user_id].to_s
      @customer=Customer.find(params[:id])
      if @customer.update_attributes({firstname:customer_params[:firstname],lastname:customer_params[:lastname]})
        session[:username]=@customer.firstname+" "+@customer.lastname
        redirect_to(customer_path(@customer))
      else
        render('edit')
      end
    else
      flash[:notice] = "You Have No Access Rights There"
      redirect_to(products_path)
    end

  end
  def show
    if params[:id].to_s==session[:user_id].to_s
      @customer=Customer.find(params[:id])
    else
      flash[:notice] = "You Have No Access Rights There"
      redirect_to(products_path)
    end

  end

private
  def customer_params
    params.require(:customer).permit(:firstname, :lastname,
                                       :email,:password,:password_confirmation)
  end
end
