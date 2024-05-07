class HomesController < ApplicationController

  def top
  end

  def about
  end

  GUEST_USER_EMAIL = "guest@example.com"

  def guest_sign_in
    member = Member.find_or_create_by!(email: GUEST_USER_EMAIL) do |member|
      member.password = SecureRandom.urlsafe_base64
      member.account_name = "guestuser"
      member.nickname = "ゲストさん"
    end
    sign_in member
    redirect_to timeline_path, notice: "guest login succeed"
  end

end
