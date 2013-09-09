ActiveAdmin.register Collaboration do
  index do
    column :project do |c|
      c.project.title
    end
    column :project_creator do |c|
      c.project.creator.public_name
    end

    column :invited_collaborator do |c|
      c.collaborator.email
    end

    column :action do |c|
      if c.pending?
        link_to 'accept', accept_admin_collaboratio_path(c)
      else
        "accepted"
      end
    end
  end

  member_action :accept do |c|
    c.accept!
    redirect_to :back, "Accepted"
  end

  show do |c|
    attributes_table do
      row(:project)
    end
  end

end
