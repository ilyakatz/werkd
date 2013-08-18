module Users
  class ProjectsController < Users::UsersController

    def new
      @project = Project.new
      @project.creator = current_user
    end

    def edit
      @project = current_user.projects.find(params[:id])
    end

    def create
      @project = Project.new(project_params)
      @project.creator = current_user

      if @project.save
        if current_user.projects.count < Project::MINIMUM_PROJECTS_PER_USER
          redirect_to new_users_project_path, notice: "Please add one more project"
        else
          redirect_to users_dashboards_path, notice: 'Project was successfully created.'
        end
      else
        render action: "new"
      end
    end

    def update
      @project = current_user.projects.find(params[:id])

      if @project.update_attributes(project_params)
        redirect_to @project, notice: 'Project was successfully updated.'
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
                                      :tag_list, :start_at, :tagged_user_ids
                                     )
    end

  end
end
