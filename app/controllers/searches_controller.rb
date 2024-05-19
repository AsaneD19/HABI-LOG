class SearchesController < ApplicationController

  def search
    redirect_back(fallback_location: home_path, notice: "no words search") if params[:search] == ""
    if params[:search].include?(" ") || params[:search].include?("　")
      split_keywords = params[:search].split(/[[:blank:]]+/)
      @member_results = []
      @habit_results = []
      split_keywords.each do |keyword|
        if keyword == ""
          next
        end
        @member_results += Member.where('name LIKE(?)', "%#{keyword}%").or(Member.where('account_id LIKE(?)', "%#{keyword}%"))
        @habit_results += Habit.where('name LIKE(?)', "%#{keyword}%")
      end
      @member_results.uniq! if @member_results.count > 1
      @habit_results.uniq! if @habit_results.count > 1
    else
      single_keyword = params[:search]
      @member_results = Member.where('name LIKE(?)', "%#{single_keyword}%").or(Member.where('account_id LIKE(?)', "%#{single_keyword}%"))
      @habit_results = Habit.where('name LIKE(?)', "%#{single_keyword}%")
    end
  end
end
