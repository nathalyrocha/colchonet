class Rooms::ReviewsController < Rooms::BaseController
  before_action :require_authentication

  def create
    review = room.reviews.find_or_initialize_by(user_id: current_user.id)

    review.update(review_params)

    redirect_to room_path(room)
  end

  def update
    create
  end

  private

  def room
    @room ||= Room.find(params[:room_id])
  end


  # Only allow a list of trusted parameters through.
  def review_params
    params.require(:review).permit(:points)
  end
end