class GroupsController < ApplicationController
  before_action :authenticate_user!, except: [:splash]
  def index
    @groups = current_user.groups
  end

  def new
    @group = current_user.groups.new
  end

  def create
    @group = current_user.groups.new(group_params)
    @group.icon.attach(params[:group][:icon])
    if @group.save
      redirect_to user_groups_path(current_user), notice: 'Catagories created successfully'
    else
      render :new
    end
  end

  def splash; end

  private
  def group_params
    params.require(:group).permit(:name,:icon)
  end
end
