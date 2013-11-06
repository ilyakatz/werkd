class HomeController <DeviseController

  #prepend_before_filter :require_no_authentication, :only => [ :index ]

  def index
    if user_signed_in?
      redirect_to users_feeds_url and return
    end
    self.resource = User.new
    render layout: false
  end

end
