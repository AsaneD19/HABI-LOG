class Public::HabitRecordsController < ApplicationController
  include CheckMemberStatus
  before_action :is_guest_member?, only: [:destroy]
  before_action ->{is_matching_login_member(HabitRecord.find(params[:id]).habit.member)}, only: [:destroy]

  def index
    @habit_records = HabitRecord.all
  end

  def show
    @habit_record = HabitRecord.find(params[:id])
    @post_comments = @habit_record.post_comments
    @post_comment = PostComment.new
  end

  def destroy
    habit_record = HabitRecord.find(params[:id])
    habit_record.destroy
    flash[:notice] = "You have deleted a post successfully."
    redirect_to home_path
  end

end
