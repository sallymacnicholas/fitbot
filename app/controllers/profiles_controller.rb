class ProfilesController < ApplicationController
  def index
    if current_user.profile
      @profile = current_user.profile
    else
      @profile = Profile.new
    end
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.create(profile_params)
    @profile.user_id = current_user.id
    @profile.save
    redirect_to profiles_path
  end

  def update
    @profile = Profile.find(params[:id])
    @profile.update(profile_params)
    redirect_to profiles_path
  end

  private

  def profile_params
    params.require(:profile).permit(:awake_time, :sleep_time)
  end
end
