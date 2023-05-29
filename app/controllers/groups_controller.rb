class GroupsController < ApplicationController
  before_action :authenticate_user!, except: [:splash]
  def index; end

  def show; end

  def new; end

  def create; end

  def destroy; end

  def splash; end
end
