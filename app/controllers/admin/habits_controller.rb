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

  def destroy
    habit = Habit.find(params[:id])
    member = habit.member
    habit.destroy
    redirect_to admin_member_habits_path(member)
  end
end
