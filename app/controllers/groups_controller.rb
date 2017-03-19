class GroupsController < ApplicationController

  before_action :authenticate_user! ,only: [:new, :create, :edit, :update, :destroy ]
  before_action :find_id_and_check_permission ,only: [:edit, :update, :destroy]

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @posts = @group.posts.recent.paginate(:page => params[:page], :per_page =>5 )
  end



  def edit
    find_id_and_check_permission
  end

  def update
    find_id_and_check_permission

    if @group.update(group_params)
      redirect_to groups_path, notice:"update Success"
    else
      render :edit
    end
  end

  def new
    @group = Group.new
  end
  def create
    @group =Group.new(group_params)
    @group.user = current_user
    # Rails.logger.debug("XXXX")
    if @group.save
      redirect_to groups_path
    else
      render :new
    end
  end

  def destroy
    find_id_and_check_permission
    @group.destroy
    flash[:alert]="Group deleted"
    redirect_to groups_path
  end

  def join
    @group = Group.find(params[:id])
    current_user.join!(@group)
    flash[:notice] = "加入成功"
    redirect_to group_path(@group)
  end

  def quit
    @group = Group.find(params[:id])
    current_user.quit!(@group)
    flash[:alert] = "已经退出本论坛"
    redirect_to group_path(@group)
  end

  private

  def find_id_and_check_permission
    @group = Group.find(params[:id])
    if @group.user != current_user
      redirect_to root_path, alert: "不好意思，你不是创建者不能操作。"
    end
  end

  def group_params
    params.require(:group).permit(:title, :description)
  end
end
