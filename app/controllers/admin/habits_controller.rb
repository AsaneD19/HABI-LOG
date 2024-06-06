class Admin::HabitsController < ApplicationController
  layout "admin"

  def index
    @member = Member.find(params[:member_id])
    @habits = @member.habits
  end

  def show
    @habit = Habit.find(params[:id])
  end
end
