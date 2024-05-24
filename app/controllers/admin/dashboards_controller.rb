class Admin::DashboardsController < ApplicationController
  layout "admin"
  def index
    @members = Member.all
  end
end
