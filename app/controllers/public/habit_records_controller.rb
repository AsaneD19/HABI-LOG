class Public::HabitRecordsController < ApplicationController

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
