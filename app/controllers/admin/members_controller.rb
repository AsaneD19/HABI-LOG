class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    @member = Member.find(params[:id])
    @member.destroy
    redirect_to admin_dashboards_path, notice: "メンバー削除完了"
  end
end
