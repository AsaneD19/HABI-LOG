class HabitsController < ApplicationController

  def new
    @habit = Habit.new
  end

  def create
    @habit = Habit.new(habit_params)
    @habit.member_id = current_member.id
    @habit.count = 0
    @habit.duration = 0
    @habit.max_duration = 0
    if @habit.save
      flash[:notice] = "You have entryed a new habit successfully."
      redirect_to habits_path
    else
      @member = current_member
      @habits = Habit.all
      flash[:alert] = @habit.errors.full_messages.join(", ")
      render :index
    end

  end

  def index
   
  end

  def show
  end

  def destroy
  end
  
  private

  def habit_params
    params.require(:habit).permit(:name, :count, :last_achivement, :duration, :max_duration, :member_id, :tag_id)
  end
end
