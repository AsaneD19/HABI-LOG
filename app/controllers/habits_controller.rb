class HabitsController < ApplicationController
  before_action :is_matching_login_member, except: [:index, :show]


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
      @tags = Tag.all
      flash[:alert] = @habit.errors.full_messages.join(", ")
      render :new
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
    @habit.achievement_count += 1
    if @habit.last_achievement != nil && Time.zone.today - @habit.last_achievement.to_date > 1
      @habit.current_duration =  1
    else
      @habit.current_duration += 1
    end
    if @habit.current_duration > @habit.max_duration
      @habit.max_duration = @habit.current_duration
    end
    @habit.last_achievement = DateTime.now

    @habit_progress = HabitProgress.new(habit_progress_params)
    @habit_progress.habit_id = @habit.id
    @habit_progress.current_duration = @habit.current_duration

    feed = Feed.new
    feed_data = Feed.new
    feed_data.habit_id = @habit.id
    feed_data.member_id = current_member.id
    feed_data.feed_type = CONST_FEED_TYPE_PROGRESS
    feed_data.comment = @habit_progress.comment
    feed_data.current_duration = @habit_progress.current_duration

    habit_progress_saved = false
    habit_updated = false
    feed_saved = false
    ActiveRecord::Base.transaction do
      habit_progress_saved = @habit_progress.save
      habit_updated = @habit.update(habit_progress_params)
      feed_saved = feed.save
    end

    if habit_progress_saved && habit_updated && feed_saved
      flash[:notice] = "Your achievement has recorded successfully."
      redirect_to member_habits_path(current_member.id)
    else
      all_errors = [
        @habit.errors.full_messages,
        @habit_progress.errors.full_messages,
        feed.errors.full_messages
      ]
      flash[:alert] = all_errors.errors.full_messages.join(", ")
      @habit = Habit.find(params[:id])
      @habit_progresses = @habit.habit_progresses
      render :show
    end

  end

  private

  def habit_params
    params.require(:habit).permit(:name, :achievement_count, :comment, :last_achivement, :duration, :max_duration, :member_id, :tag_id, :profile_image)
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


  def set_habit_progress_data(habit_progress, habit)

    return habit_progress
  end

  def set_feed_data(feed_data, habit, feed_type)

    return feed_data
  end

end
