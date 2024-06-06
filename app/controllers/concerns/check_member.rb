module CheckMember
  extend ActiveSupport::Concern

  def is_matching_login_member(member)
    unless member.id == current_member.id
      redirect_to home_path
    end
  end

  def is_guest_member?
    if current_member.email == CONST_GUEST_USER_EMAIL
      guest_logout
    end
  end

  def guest_logout
    flash[:notice] = "サインイン、あるいはログインしてください"
    sign_out(current_member)
    redirect_to root_path
  end

end