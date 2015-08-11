class ProfileController < ApplicationController
  def show
    @goal = Goal.new
  end
end
