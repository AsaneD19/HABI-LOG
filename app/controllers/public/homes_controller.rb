class Public::HomesController < ApplicationController

  def top
  end

  def about
  end


  def guest_sign_in
    member = Member.find_or_create_by!(email: CONST_GUEST_USER_EMAIL) do |member|
      member.password = SecureRandom.urlsafe_base64
      member.account_id = "guestuser"
      member.name = "ゲストさん"
    end
    sign_in member
    redirect_to home_path, notice: "guest log in succeed"
  end

end
