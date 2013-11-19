module Users
  class ProjectsController < Users::UsersController

    def new
      @project = Project.new
      @collaboration = @project.collaborations.build
      @collaborator_skills=[]
    end

    def edit
      @project = Project.find(params[:id])
      @collaboration = @project.collaborations.where(user_id: current_user.id).first
      unless @collaboration
        @collaboration = @project.collaborations.create(collaborator: current_user)
      end
      @collaborator_skills = @collaboration.skills.collect {|t| {name: t.name} }.to_json
    end

    def create
      @project = Project.new(project_params)
      @project.creator = current_user

      if @project.save
        @collaboration = @project.reload.collaborations.first
        @collaboration.skill_list = params[:collaborator_skills]
        @collaboration.contribution = params[:project][:contribution]
        @collaboration.save!

        if current_user.projects.count < Project::MINIMUM_PROJECTS_PER_USER
          redirect_to new_users_project_path, notice: current_user.missing_project_message
        else
          redirect_to users_feeds_path, notice: 'Project was successfully created.'
        end
      else
        render action: "new"
      end
    end

    def update
      @project = Project.find(params[:id])
      @collaboration = @project.collaborations.where(user_id: current_user.id).first
      @collaboration.skill_list = params[:collaborator_skills]
      @collaboration.contribution = params[:project][:contribution]

      if @project.update_attributes(project_params) && @collaboration.save!
        redirect_to users_dashboards_path, notice: 'Project was successfully updated.'
      else
        render action: "edit"
      end
    end

    def destroy
      @project = current_user.projects.find(params[:id])
      @project.destroy

      redirect_to action: :index
    end

    private

    def project_params
      params.require(:project).permit(:company, :title, :user_id,
                                      :video, :contribution, :media_url,
                                      :tag_list, :start_at, :tagged_user_ids,
                                      :collaborations_attributes => [:user_id, :project_id, :skill_list]
                                     )
    end

  end
end
