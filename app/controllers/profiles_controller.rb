class ProfilesController < ApplicationController
  def index
    @profile = Profile.new
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.create(profile_params)
    @profile.user_id = current_user.id
    @profile.save
    redirect_to profile_index_path
  end

  private

  def profile_params
    params.require(:profile).permit(:awake_time, :sleep_time)
  end
end
