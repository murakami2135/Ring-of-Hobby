# frozen_string_literal: true

class GroupsController < ApplicationController
  before_action :move_to_signed_in, except: []

  def index
    @groups = Group.page(params[:page]).reverse_order
    @group_joining = GroupUser.where(user_id: current_user.id)
    @group_lists_none = 'グループに参加していません。'
  end

  def search
    @groups = Group.search(params[:keyword])
    @keyword = params[:keyword]
    render 'index'
  end

  def new
    @group = Group.new
    @group.users << current_user
  end

  def create
    @group = Group.new(group_params)

    @group.group_users << GroupUser.new(user_id: current_user.id)

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
    a = @group.group_users.find_by(user_id: current_user.id)
    a.destroy
  end

  def join
    @group = Group.find_by(id: params[:id])
    unless @group.users.include?(current_user)
      @group.users << current_user
      redirect_to groups_path
    end
  end

  def participant
    @groups = Group.all
    @group_participant = GroupUser.where(user_id: current_user.id)
    @group_lists_none = 'グループに参加していません。'
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :overview, :image)
  end
end
