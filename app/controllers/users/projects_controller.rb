module Users
  class ProjectsController < Users::UsersController

    def index
      @projects = current_user.projects
    end

    def show
      @project = current_user.projects.find(params[:id])
    end

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
        redirect_to [:users,@project], notice: 'Project was successfully created.'
      else
        render action: "new"
      end
    end

    def update
      @project = current_user.projects.find(params[:id])

      if @project.update_attributes(project_params)
        redirect_to [:users, @project], notice: 'Project was successfully updated.'
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
        :video, :contribution, :media_url, :collaborators)
    end

  end
end
