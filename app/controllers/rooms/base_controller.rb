class Rooms::BaseController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :require_authentication

  private

  def room
    @room ||= Room.find(params[:id])
  end
end