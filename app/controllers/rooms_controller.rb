class RoomsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :search]#全てのアクション(showアクションを除く)前にユーザーがログインしているかを確認

  def index #登録済みルーム画面
    @rooms = current_user.rooms.all
    flash[:notice] = "ログインしていません" unless user_signed_in?
  end

  def new #新規登録画面
    @room = current_user.rooms.new
  end

  def create #登録処理
    @room = current_user.rooms.new(room_params)
    if @room.save
      redirect_to rooms_path
      flash[:notice] = "#{@room.room_name}を登録しました。"
    else
      flash[:alert] = "登録に失敗しました. <br>・#{@room.errors.full_messages.join('<br>・')}"
      render"new"
    end
  end

  def show #詳細画面
    @room = Room.find(params[:id])

  end

  def edit #編集処理
    @room = Room.find(params[:id])
  end

  def update #更新処理
    room = Room.find(params[:id])
    room.update(room_params)
    redirect_to rooms_path
  end

  def destroy #削除処理
    binding.pry
    @room = Room.find(params[:id])
    @room.destroy
    redirect_to rooms_path
    flash[:notice] = "#{@room.room_name}を削除しました。"
  end

  private
    def room_params
      params.require(:room).permit(:id, :room_name, :introduction, :price, :address, :room_image)
    end
end
