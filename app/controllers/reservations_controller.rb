class ReservationsController < ApplicationController
  before_action :authenticate_user!

  before_action :permit_params, only: :confirm

  def index #予約済みルーム一覧
    @reservations = current_user.reservations.all
    @search = Room.select("address")
    @q = @search.ransack(params[:q])
    @searches = @q.result(distinct: true).recent
  end

  def confirm #予約確認画面
    @reservation = Reservation.new(@attr)
    @room = Room.find(params[:room_id])
      if @reservation.invalid?
        flash[:alert] = "入力に不備があります。<br>・#{@reservation.errors.full_messages.join('<br>・')}"
        redirect_to room_path(@room)
      end
  end

  def create
    @reservation = current_user.reservations.new(reservation_params)
    @room = Room.find(params[:reservation][:room_id])
    if params[:commit] == "戻る"
      redirect_to room_path(@room)
    elsif @reservation.save
      redirect_to reservations_complete_path
      flash[:notice] = "予約が完了しました。"
    end
  end

  private
  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :persons, :room_id, :room_name, :user_id)
  end

  def permit_params
    @attr = params.permit(:start_date, :end_date, :persons, :room_id, :room_name, :user_id)
  end
end
