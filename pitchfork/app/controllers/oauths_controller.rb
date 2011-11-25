class OauthsController < ApplicationController
  skip_before_filter :require_login
  
  # sends the user on a trip to the provider,
  # and after authorizing there back to the callback url.
  def oauth
    login_at(params[:provider])
  end
  
  def callback
    provider = params[:provider]
    if @user = login_from(provider)
      logger.info @user_hash
      redirect_to root_path, :notice => "Logged in from #{provider.titleize}!" 
    else
      begin
        logger.info "preparing to create..."
        @user = create_from(provider)
        logger.info "created OK"
        # @user.activate!
        # logger.info "activated OK"
        reset_session # protect from session fixation attack
        logger.info "reset_session OK"
        auto_login(@user)
        # login_user(@user)
        logger.info "auto_login OK"
        redirect_to root_path, :notice => "User created & logged in from #{provider.titleize}!"
      rescue
        redirect_to root_path, :alert => "Failed to login from #{provider.titleize}!"
      end
    end
  rescue
    redirect_to root_path, :alert => "Failed to login from #{provider.titleize}!"
  end
  
  def destroy
    logout
    redirect_to('/', :notice => 'Logged out!')
  end

end
