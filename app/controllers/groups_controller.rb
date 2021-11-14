class GroupsController < ApplicationController

  def index
    @groups = Group.all
    @group_joining = GroupUser.where(user_id: current_user.id)
    @group_lists_none = "グループに参加していません。"
  end

  def search
    @groups = Group.search(params[:keyword])
    @keyword = params[:keyword]
    render "index"
  end

  def new
    @group = Group.new
    @group.users << current_user
  end

  def create
    @group = Group.new(group_params)

    params[:group][:user_ids].each do |guid|
      @group.group_users.new(user_id: guid.to_i)
    end

    if @group.save!
      redirect_to groups_url, notice: 'グループを作成しました。'
    else
      render :new
    end
  end

  def show
    @group = Group.find(params[:id])
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_path
    else
      render :edit
    end
  end

  def destroy
    @groups = Group.all
    @group = Group.find(params[:id])
    a = @group.group_users.find_by(user_id:current_user.id)
    a.destroy
  end

  def join
    @group = Group.find_by(id: params[:id])
    if !@group.users.include?(current_user)
      @group.users << current_user
      redirect_to groups_path
    end
  end

  def participant
    @groups = Group.all
    @group_participant = GroupUser.where(user_id: current_user.id)
    @group_lists_none = "グループに参加していません。"
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :overview, :image)
  end

end