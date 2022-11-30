class ProfilesController < ApplicationController
  def edit
    @user = current_user
  end

  def update
    @user = User.find(current_user.id)
    if @user.update!(user_params)
      render path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:runner, :run_level, :password, :surfer, :surf_level)
  end
end
