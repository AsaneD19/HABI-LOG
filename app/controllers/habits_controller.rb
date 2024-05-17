class HabitsController < ApplicationController
  before_action :is_matching_login_member, except: [:index, :show]
  before_action :ensure_guest_member, only: [:new, :create, :update, :destroy]

  def new
    @habit = Habit.new
    @tags = Tag.all
  end

  def create
    @habit = Habit.new(habit_params)
    @habit.member_id = current_member.id

    feed = Feed.new
    feed.member_id = current_member.id
    feed.text_content = @habit.caption
    feed.current_duration = 0

    habit_saved = false
    feed_saved = false
    ActiveRecord::Base.transaction do
      if habit_saved = @habit.save
        feed.habit_id = @habit.id
        feed_saved = feed.save
      end
    end

    if habit_saved && feed_saved
      flash[:notice] = "You have entered a new habit successfully."
      redirect_to member_habits_path
    else
      all_errors = [
        @habit.errors.full_messages,
        feed.errors.full_messages
      ]
      flash[:alert] = all_errors.join(", ")
      @member = current_member.id
      @tags = Tag.all
      render :new
    end

  end

  def index
    @habits = Member.find(params[:member_id]).habits
  end

  def show
    @habit = Habit.find(params[:id])
    @habit_records = @habit.habit_records
    @habit_record = HabitRecord.new
  end

  def destroy
    habit = Habit.find(params[:id])
    habit.destroy
    flash[:notice] = "Your entered habit has been deleted successfully."
    redirect_to member_habits_path
  end

  def update

    @habit = Habit.find(params[:id])
    if @habit.last_achievement != nil && Time.zone.today - @habit.last_achievement.to_date > 1
      current_duration =  1
    else
      current_duration = @habit.current_duration + 1
    end
    if @habit.current_duration == 0
      max_duration = 1
    elsif @habit.current_duration > @habit.max_duration
      max_duration = @habit.current_duration
    end

    last_achievement = Time.zone.now

    @habit_record = HabitRecord.new(habit_record_params)
    @habit_record.habit_id = @habit.id
    @habit_record.current_duration = @habit.current_duration

    feed = Feed.new
    feed.habit_id = @habit.id
    feed.member_id = current_member.id
    feed.text_content = @habit_record.comment
    feed.current_duration = current_duration

    habit_record_saved = false
    habit_updated =false
    feed_saved = false
    ActiveRecord::Base.transaction do
      habit_record_saved = @habit_record.save
      habit_updated = @habit.update(achievement_count: @habit.achievement_count + 1, current_duration: current_duration, max_duration: max_duration, last_achievement: Time.zone.now)
      feed_saved = feed.save
    end

    if habit_record_saved && habit_updated && feed_saved
      flash[:notice] = "Your achievement has recorded successfully."
      redirect_to member_habits_path(current_member.id)
    else
      all_errors = [
        @habit.errors.full_messages,
        @habit_record.errors.full_messages,
        feed.errors.full_messages
      ]
      flash[:alert] = all_errors.join(", ")
      @habit = Habit.find(params[:id])
      @habit_records = @habit.habit_records
      render :show
    end

  end

  private

  def habit_params
    params.require(:habit).permit(:name, :achievement_count, :caption, :last_achivement, :current_duration, :max_duration, :member_id, :tag_id)
  end

  def habit_record_params
    params.require(:habit_record).permit(:habit_id, :comment, :current_duration)
  end

  def is_matching_login_member
    member = Member.find(params[:member_id])
    unless member.id == current_member.id
      redirect_to home_path
    end
  end

  def ensure_guest_member
    if current_member.email == CONST_GUEST_USER_EMAIL
      flash[:alert] = "A prohibited action by guest member. please log in or sign up"
      sign_out(current_member)
      redirect_to root_path
    end
  end

end