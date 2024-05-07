class HabitsController < ApplicationController

  def new
    @habit = Habit.new
  end

  def create
    @habit = Habit.new(habit_params)
    @habit.user_id = current_user.id
    if @habit.save
      flash[:notice] = "You have entryed a new habit successfully."
      redirect_to habits_path
    else
      @user = current_user
      @habits = Habit.all
      flash[:alert] = @habit.errors.full_messages.join(", ")
      render :index
    end

  end

  def index
    @member = current_member
    @habits = @member.habits
  end

  def show
  end

  def destroy
  end
end
