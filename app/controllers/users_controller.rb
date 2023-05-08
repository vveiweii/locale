class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to dashboard_index_path, notice: 'Your profile was successfully updated.'
    else
      render dashboard_index_path, notice: 'Your profile was not updated.'
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path, notice: 'Your profile was successfully deleted.'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :address, :city, :state, :postcode, :date_of_birth)
  end
end
