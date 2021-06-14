class RoomsController < ApplicationController
  before_action :require_authentication, only: [:new, :edit, :create, :update, :destroy]

  PER_PAGE = 10

  # GET /rooms or /rooms.json
  def index
    @search_query = params[:q]
    
    rooms = Room.search(@search_query)

    @rooms = Kaminari.paginate_array(RoomCollectionPresenter.new(rooms.all, self).to_ary).page(params[:page]).per(10)
  end

  # GET /rooms/1 or /rooms/1.json
  def show
    room_model = Room.friendly.find(params[:id])

    if user_signed_in?
      @room = RoomPresenter.new(room_model, self)
    end
  end

  # GET /rooms/new
  def new
    @room = current_user.rooms.build
  end

  # GET /rooms/1/edit
  def edit
    @room = current_user.rooms.friendly.find(params[:id])
  end

  # POST /rooms or /rooms.json
  def create
    @room = current_user.rooms.build(room_params)

    if @room.save
      redirect_to @room, notice: t('flash.notice.room_created')
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /rooms/1 or /rooms/1.json
  def update
    @room = current_user.rooms.friendly.find(params[:id])
  
    if @room.update(room_params)
      redirect_to @room, notice: t('flash.notice.room_updated')
    else
      render action: 'edit'
    end
  end

  # DELETE /rooms/1 or /rooms/1.json
  def destroy
    @room = current_user.rooms.find(params[:id])
    @room.destroy

    redirect_to rooms_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def room_params
      params.require(:room).permit(:title, :location, :description, :picture)
    end
end
