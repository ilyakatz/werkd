class HomeController <DeviseController

  prepend_before_filter :require_no_authentication, only: :index

  def index
    if user_signed_in?
      redirect_to users_dashboards_path and return
    end
#    resource = build_resource({})
    render layout: false
  end

end
