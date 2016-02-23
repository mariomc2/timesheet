class BranchesController < ApplicationController
  
  layout "professional"

  before_action :set_locale
  before_action :current_user

  def index    
    if @is_company 
      @branches = @current_user.branches
    else
      if params[:company_id]
        @branches = Branch.where(company_id: params[:company_id])
      else
        redirect_to([@current_user, :companies])
      end
    end 
  end

  def show
    @branch = Branch.find(params[:id])
  end

  def new
    if @is_company
      @branch = @current_user.branches.new()
    else
      if params[:company_id]
        @branch = Branch.new(company_id: params[:company_id])
      else
        redirect_to([@current_user, :companies])
      end
    end
  end

  def create
    # Instantiate a new object using form parameters
    @branch = Branch.new(branch_params)
    # Save the object
    if @branch.save
    # If save succeeds, redirect to the index action
      flash[:notice] = "#{t(:branch)} #{t(:create_success)}"
      redirect_to([@current_user, :branches])
    else
    # If save fails, redisplay the from so user can fix problems
      render('new')
    end
  end

  def edit
    @branch = Branch.find(params[:id])
  end

  def update
    # Find and existing object using form parameters
    @branch = Branch.find(params[:id])
    # Update the object
    if @branch.update_attributes(branch_params)
      # If update succeeds, redirect to the index action
      flash[:notice] = "#{t(:branch)} #{t(:update_success)}"
      redirect_to([@current_user, @branch])
    else
      # If save fails, redisplay the from so user can fix problems
      render('edit')
    end
  end

  def delete
    @branch = Branch.find(params[:id])
  end

  def destroy
    branch = Branch.find(params[:id]).destroy
    flash[:notice] = "#{t(:branch)} '#{branch.name}' #{t(:destroy_success)}"
    redirect_to([@current_user, :branches])
  end

  private

    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end

    def branch_params
      # same as using "params[:professional]", except taht it:
      # - raises an error if :professional is not present
      # - allows listed attributes to be mass-assigned
      params.require(:branch).permit(:company_id, :name, :id_code, :email, :time_zone)
    end
end
