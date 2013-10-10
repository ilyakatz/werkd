ActiveAdmin.register UserInvite do
  index do
    column :token
    column :used_at
    column :link do |ui|
      root_url(beta: ui.token)
    end
    default_actions
  end

  controller do
    def permitted_params
      params.permit(user_invite: [:token])
    end
  end

end
