class GroupsController < ApplicationController
  before_action :authenticate_user!, except: [:splash]
  def index
    @groups = current_user.groups
  end

  def show
    @group= Group.find(params[:id])
    @expenses = @group.expenses.order('created_at DESC')
  end

  def new; end

  def create; end

  def destroy; end

  def splash; end
end
