class Admin::HabitsController < ApplicationController
  layout "admin"

  def index
    @member = Member.find(params[:member_id])
    @habits = @member.habits
  end

  def show
    @habit = Habit.find(params[:id])
    @habit_records = @habit.habit_records
  end
end
