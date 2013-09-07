ActiveAdmin.register User do
  index do
    column :first_name
    column :email
    default_actions
  end

  filter :email

end
