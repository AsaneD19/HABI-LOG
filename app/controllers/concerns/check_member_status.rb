module CheckMemberStatus
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

  def is_private_member?(member)
    if member != current_member && member.is_private == true
      flash[:notice] = "非公開設定のメンバーの情報は閲覧できません"
      redirect_to home_path
    end
  end

  def guest_logout
    flash[:notice] = "メンバー登録が必要です"
    sign_out(current_member)
    redirect_to root_path
  end

  def check_activation
    if current_member.is_active == false
      reset_session
      flash[:notice] = "退会済です"
      redirect_to root_path
    end
  end

end