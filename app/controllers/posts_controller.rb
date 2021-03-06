class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_group
  before_action :member_required, only: [:new, :create]
# before_action 是一個常見的 controller 技巧,用來收納重複的程式碼。
# before_action 可以用 only,指定某些 action 執行:
# before_action :find_group, only: [:edit, :update]
# 或者使用 except,排除某些 action 不執行:
# before_action :find_group, except: [:show, :index]
# 還有一個 after_action => 同 before_action, 用於執行完成 action 後的動作

  def new
    @post = @group.posts.new
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def create
    @post = @group.posts.build(post_params)
    @post.author = current_user

    if @post.save
      redirect_to group_path(@group), notice: "新增文章成功！"
    else
      render :new
    end
  end

  def update
    @post = current_user.posts.find(params[:id])

    if @post.update(post_params)
      redirect_to group_path(@group), notice: "文章修改成功！"
    else
      render :edit
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])

    @post.destroy
    redirect_to group_path(@group), alert: "文章已刪除！"
  end

  private

  def find_group
    @group = Group.find(params[:group_id])
  end

  def post_params
    params.require(:post).permit(:content)
  end

  def member_required
    if !current_user.is_member_of?(@group)
      flash[:warning] = "你不是這個討論板的成員，不能發文！"
      redirect_to group_path(@group)
    end
  end
end
