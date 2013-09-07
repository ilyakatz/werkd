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

    column "status" do |c|
      !!c.accepted_at ? "accepted" : "pending"
    end
    default_actions
  end

end
