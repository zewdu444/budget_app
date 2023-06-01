class GroupsController < ApplicationController
  before_action :authenticate_user!, except: [:splash]
  load_and_authorize_resource except: [:splash]
  def index
    @groups = current_user.groups.order(created_at: :desc)
  end

  def new
    @group = current_user.groups.new
  end

  def create
    if params[:group][:icon].present?
      uploaded_file = params[:group][:icon].tempfile
      cloudinary_response = Cloudinary::Uploader.upload(uploaded_file.path, folder: 'group_icons')
      params[:group][:icon] = cloudinary_response['secure_url']
      @group = current_user.groups.new(group_params)
    end
    if @group.save
      redirect_to authenticated_root_path, notice: 'Categories created successfully'
    else
      render :new
    end
  end

  def splash; end

  private

  def group_params
    params.require(:group).permit(:name, :icon)
  end
end
