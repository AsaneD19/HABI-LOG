class Admin::MembersController < ApplicationController
  layout "admin"
  def destroy
    @member = Member.find(params[:id])
    @member.destroy
    redirect_to admin_dashboards_path, notice: "メンバー削除完了"
  end

  def show
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)
      redirect_to admin_dashboards_path, notice: "更新完了"
    else
      @member.errors.full_messages.join(", ")
      render :show
    end
  end
  private

  def member_params
    params.require(:member).permit(:account_id, :email, :name, :introduction, :is_private, :is_active, :profile_image)
  end

end
