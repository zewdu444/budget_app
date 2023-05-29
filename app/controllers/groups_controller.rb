class GroupsController < ApplicationController
  before_action :authenticate_user!, except: [:splash]
  def index
    @groups = current_user.groups
  end

  def show
    @group= Group.find(params[:id])
    @expenses = @group.expenses.order('created_at DESC')
  end

  def new
    @group = current_user.groups.new
  end

  def create
    @group = current_user.groups.new(group_params)
    if @group.save
      redirect_to user_groups_path(current_user), notice: 'Catagories created successfully'
    else
      render :new
    end
  end

  def destroy; end

  def splash; end

  def group_params
    params.require(:group).permit(:name,:icon)
  end

end
