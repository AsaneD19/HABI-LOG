class SearchesController < ApplicationController

  def search
    @keywords = params[:search]
    @member_results = Member.where('members.name LIKE(?)', "%#{@keywords}%").or(Member.where('members.account_id LIKE(?)', "%#{@keywords}%"))
    @habit_results = Habit.where('habits.name LIKE(?)', "%#{@keywords}%")
  end

end
