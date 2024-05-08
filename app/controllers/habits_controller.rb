class HabitsController < ApplicationController
  before_action :is_matching_login_member, except: [:index, :show]

  CONST_TYPE_ENTRY = 0
  CONST_TYPE_ACHIEVEMENT = 1

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
    @habits = Member.find(params[:member_id]).habits
  end

  def show
    @habit = Habit.find(params[:id])
    @habit_progresses = @habit.habit_progresses
    @habit_progress = HabitProgress.new
  end

  def destroy
    habit = Habit.find(params[:id])
    habit.destroy
    flash[:notice] = "Your entered habit has been deleted successfully."
    redirect_to member_habits_path
  end

  def update
    @habit = Habit.find(params[:id])
    count, last_achievement, duration, max_duration = set_achievement_data(@habit)
    @habit_progress = HabitProgress.new(habit_progress_params)
    @habit_progress.habit_id = @habit.id
    @habit_progress.duration = duration

    if @habit_progress.save
      @habit.update(count: count,
                    duration: duration,
                    max_duration: max_duration,
                    last_achievement: last_achievement)
      flash[:notice] = "Your achievement has recorded successfully."
      redirect_to member_habits_path(current_member.id)
    else
      flash[:alert] = @habit_progress.errors.full_messages.join(", ")
      @habit = Habit.find(params[:id])
      @habit_progresses = @habit.habit_progresses
      render :show
    end
  end

  protected

  private

  def habit_params
    params.require(:habit).permit(:name, :count, :comment, :last_achivement, :duration, :max_duration, :member_id, :tag_id, :profile_image)
  end

  def habit_progress_params
    params.require(:habit_progress).permit(:habit_id, :comment, :duration)
  end

  def is_matching_login_member
    member = Member.find(params[:member_id])
    unless member.id == current_member.id
      redirect_to timeline_path
    end
  end

  def set_achievement_data(habit)

    count = habit.count + 1

    if habit.last_achievement != nil && Time.zone.today - habit.last_achievement > 1
      duration =  1
    else
      duration = habit.duration + 1
    end

    if duration > habit.max_duration
      max_duration = duration
    else
      max_duration = habit.max_duration
    end

    last_achievement = Time.zone.today
    return count, last_achievement, duration, max_duration
  end

end
