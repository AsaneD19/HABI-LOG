class Public::HabitsController < ApplicationController
  include CheckMemberStatus
  before_action :is_guest_member?, only: [:new, :create, :update, :destroy]
  before_action ->{is_matching_login_member(Member.find(params[:member_id]))}, except: [:index, :show]
  before_action ->{is_private_member?(Member.find(params[:member_id]))}, only: [:index, :show]

  def new
    @habit = Habit.new
    @tags = Tag.all
  end

  def create
    @habit = Habit.new(habit_params)
    @habit.member_id = current_member.id
    if @habit.save
      send_feed(@habit.id, @habit.caption, 0)
      flash[:notice] = "You have entered a new habit successfully."
      redirect_to member_habits_path
    else
      flash[:alert] = @habit.errors.full_messages.join(", ")
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
    @habit = set_habit_update_params(Habit.find(params[:id]))
    @habit_record = set_habit_record_params(HabitRecord.new(habit_record_params), @habit.id, @habit.current_duration)
    if @habit_record.save
      @habit.update(achievement_count: @habit.achievement_count + 1, current_duration: @habit.current_duration, max_duration: @habit.max_duration, last_achievement: @habit.last_achievement)
      send_feed(@habit.id, @habit_record.comment, @habit.current_duration)
      flash[:notice] = "Your achievement has recorded successfully."
      redirect_to member_habit_path(@habit)
    else
      flash[:alert] = @habit_record.errors.full_messages.join(", ")
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

  def send_feed(habit_id, text_content, current_duration)
    feed = Feed.new
    feed.habit_id = habit_id
    feed.member_id = current_member.id
    feed.text_content = text_content
    feed.current_duration = current_duration
    feed.save
  end

  def set_habit_update_params(habit)
    if habit.last_achievement != nil && Time.zone.today - habit.last_achievement.to_date > 1
      habit.current_duration =  1
    else
      habit.current_duration += 1
    end
    if habit.current_duration == 0
      habit.max_duration = 1
    elsif habit.current_duration > habit.max_duration
      habit.max_duration = habit.current_duration
    end
    habit.last_achievement = Time.zone.now
    return habit
  end

  def set_habit_record_params(habit_record, habit_id, current_duration)
    habit_record.habit_id = habit_id
    habit_record.current_duration = current_duration
    return habit_record
  end

end