class ChatsController < ApplicationController
  def show

    # join_flgがfalseの場合に参加、参加していないとしてredirect
    # 今ログインしているユーザーのIDがグループに含まれているか？
    join_flg = current_user.group_users.pluck(:group_id).include?(params[:id].to_i)
    # unlessは、ifの反対の意味
    # 含まれていないならredirect
    redirect_to groups_path unless join_flg

    # ChatテーブルからChatの一覧を入手
    @chats = Chat.where(group_id: params[:id])

    # chat入力欄ようのnew
    @chat = Chat.new(group_id: params[:id])
  end

  def create
    @chat = current_user.chats.new(chat_params)
    @chat.save
    redirect_to request.referer
  end

  private
  def chat_params
    params.require(:chat).permit(:message, :group_id)
  end
end
