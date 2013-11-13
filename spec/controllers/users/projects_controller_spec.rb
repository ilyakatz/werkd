require 'spec_helper'

describe Users::ProjectsController do
  render_views

  shared_examples_for 'a project' do
    let(:project) { assigns(:project) }
    subject { project }
    it { should be }
    its(:company) { should == company }
    its(:title) { should == title }
    its(:media_url) { should == media_url }
    its(:contribution) { should == contribution }
    its(:start_at) { should == start_at }
  end # shared examples for a project

  describe '#create' do
    let!(:current_user) { create(:user) }
    let(:company) { Faker::Company.name }
    let(:title) { Faker::Commerce.product_name }
    let(:media_url) { Faker::Internet.url }
    let(:contribution) { 'I made this' }
    let(:start_at) { Date.yesterday }
    let(:project_params) { {
      company: company,
      title: title,
      media_url: media_url,
      contribution: contribution,
      start_at: start_at
    } }
    let(:collaborator_skills) { 'Steady Cam, Video Editing' }
    let(:post_params) { {project: project_params, collaborator_skills: collaborator_skills} }
    let(:action_response) { post(:create, post_params) }
    let(:before_action) { }
    before {
      stub_cloudinary({url: media_url})
      stub_embedly({url: media_url})
      sign_in(current_user)
      before_action
      action_response
    }
    subject { action_response }

    context 'when project data is valid' do

      context 'when user has less than min projects per user' do
        it_behaves_like('a project')
        it { should redirect_to(new_users_project_path) }
      end # when user has min projects per user

      context 'when user has more than min projects per user' do
        let(:before_action) {
          (Project::MINIMUM_PROJECTS_PER_USER + 1).times.each {
            create(:project, creator: current_user)
          }
        }
        it_behaves_like('a project')
        it { should redirect_to(users_feeds_path) }
      end # when user has more than min projects per user

    end # when project data is valid

    context 'when project data is invalid' do
      let(:title) { '' }
      it { should render_template(:new) }
    end # when project data is invalid

  end # create

  describe '#update' do
    let!(:current_user) { create(:user) }
    let(:user_project) { create(:project) }
    let(:project_id) { user_project.id }
    let(:company) { Faker::Company.name }
    let(:title) { Faker::Commerce.product_name }
    let(:media_url) { Faker::Internet.url }
    let(:contribution) { 'I made this' }
    let(:start_at) { Date.yesterday }
    let(:project_params) { {
      company: company,
      title: title,
      media_url: media_url,
      contribution: contribution,
      start_at: start_at
    } }
    let(:collaborator_skills) { 'Steady Cam, Video Editing' }
    let(:post_params) { {id: project_id, project: project_params, collaborator_skills: collaborator_skills} }
    let(:action_response) { put(:update, post_params) }
    let(:before_action) { }
    before {
      stub_cloudinary({url: media_url})
      stub_embedly({url: media_url})
      current_user.projects << user_project
      sign_in(current_user)
      before_action
      action_response
    }
    subject { action_response }

    context 'when project data is valid' do
      it_behaves_like('a project')
      it { should redirect_to(users_dashboards_path) }
    end # when project data is valid

    context 'when project data is invalid' do
      let(:title) { '' }
      it { should render_template(:edit) }
    end # when project data is invalid

  end # update

end
