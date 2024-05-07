class HabitsController < ApplicationController

  def new
    @habit = Habit.new
    @tags = Tag.all
  end

  def create
    @habit = Habit.new(habit_params)
    @habit.member_id = current_member.id
    if @habit.save
      flash[:notice] = "You have entered a new habit successfully."
      redirect_to member_habits_path
    else
      @member = current_member
      @habits = @member.habits
      flash[:alert] = @habit.errors.full_messages.join(", ")
      render :index
    end

  end

  def index
    @member = Member.find(params[:member_id])
    @habits = @member.habits
    @tags = Tag.all
  end

  def show
  end

  def destroy
  end

  protected

  private

  def habit_params
    params.require(:habit).permit(:name, :count, :comment, :last_achivement, :duration, :max_duration, :member_id, :tag_id, :profile_image)
  end
end
