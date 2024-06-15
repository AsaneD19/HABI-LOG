class Public::SessionsController < Devise::SessionsController

  def failed
    redirect_to root_path
  end


  def after_sign_in_path_for(resource)
    home_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  protected

  def auth_options
    { scope: resource_name, recall: "#{controller_path}#failed" }
  end

end
