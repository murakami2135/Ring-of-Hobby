class ChatsController < ApplicationController
  def show
    # どのユーザーとチャットするかを取得。
    @user = User.find(params[:id])
    # カレントユーザーのgroup_userにあるgroup_idの値の配列をgroupsに代入。
    groups = current_user.group_users.pluck(:group_id)
    # group_userモデルから
    # user_idがチャット相手のidが一致するものと、
    # group_idが上記groupsのどれかに一致するレコードを
    # group_usersに代入。
    group_users = GroupUser.find_by(user_id: @user.id, group_id: groups)

    # もしuser_roomが空でないなら
    unless group_users.nil?
      # @groupに上記group_userのgroupを代入
      @group = group_users.group
    else
      # それ以外は新しくroomを作り、
      @group = Group.new
      @group.save
      # group_userをカレントユーザー分とチャット相手分を作る
      GroupUsers.create(user_id: current_user.id, group_id: @group.id)
      GroupUsers.create(user_id: @user.id, group_id: @group.id)
    end
    @chats = @group.chats
    @chat = Chat.new(group_id: @group.id)
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
