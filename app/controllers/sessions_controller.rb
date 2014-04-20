class SessionsController < ApplicationController

  def create
	user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    session[:access_token]=env['omniauth.auth']['credentials']['token']
    logger.info "access token generated: #{session[:access_token]}"
    #render :controller => 'questionsets',:action => 'share'
    share
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

  private

  def share
    logger.info "questions controller access token: #{session[:access_token]}"
    me = FbGraph::User.me(session[:access_token])
    me.feed!(
      :message => 'Updating via FbGraph',
      :picture => 'https://graph.facebook.com/matake/picture',
      :link => 'https://github.com/nov/fb_graph',
      :name => 'FbGraph',
      :description => 'A Ruby wrapper for Facebook Graph API'
    )
  end

end
