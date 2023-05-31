class GroupsController < ApplicationController
  before_action :authenticate_user!, except: [:splash]
  def index
    @groups = current_user.groups.order(created_at: :desc)
  end

  def new
    @group = current_user.groups.new
  end

  def create
    if params[:group][:picture].present?
      uploaded_file = params[:group][:picture].tempfile
      cloudinary_response = Cloudinary::Uploader.upload(uploaded_file.path, folder: "group_icons")
      @group = current_user.groups.new(group_params.merge(icon: cloudinary_response['secure_url']).except(:picture))
    else
      @group = current_user.groups.new(group_params.except(:picture))
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
    params.require(:group).permit(:name, :picture)
  end
end
