require 'spec_helper'

describe Users::ProjectsController do
  render_views

  shared_examples_for 'a project' do

    context 'project' do
      subject { assigns(:project) }
      it { should be }
      its(:company) { should == company }
      its(:title) { should == title }
      its(:media_url) { should == media_url }
      its(:contribution) { should == contribution }
      its(:start_at) { should == start_at }
    end # project

    context 'collaboration' do
      subject { assigns(:collaboration) }
      its(:id) { should be }
      its(:skill_list) { should =~ collaborator_skills.split(', ') }
      its(:contribution) { should == contribution }
      its(:collaborator) { should == current_user }
    end # collaboration

  end # shared examples for a project

  describe '#new' do
    let!(:current_user) { create(:user) }
    let(:action_response) { get(:new) }
    before {
      sign_in(current_user)
      action_response
    }
    subject { action_response }
    it { should be_success }

    context 'project' do
      subject { assigns(:project) }
      it { should be }
    end # project

    context 'collaboration' do
      subject { assigns(:collaboration) }
      it { should be }
    end # collaboration

    context 'collaborator_skills' do
      subject { assigns(:collaborator_skills) }
      it { should be }
    end # collaborator_skills

  end # new

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

  describe '#edit' do
    let(:current_user) { create(:user) }
    let(:project) { create(:project) }
    let(:get_params) { {id: project.id} }
    let(:action_response) { get(:edit, get_params) }
    before {
      create(:collaboration, project: project, collaborator: current_user)
      sign_in(current_user)
      action_response
    }
    subject { action_response }
    it { should be_success }

    context 'project' do
      subject { assigns(:project) }
      it { should be }
    end # project

    context 'collaboration' do
      subject { assigns(:collaboration) }
      it { should be }
      its(:collaborator) { should == current_user }
    end # collaboration

    context 'collaborator_skills' do
      subject { assigns(:collaborator_skills) }
      it { should be }
    end # collaborator_skills

  end # new

  describe '#update' do
    let(:current_user) { create(:user) }
    let(:project) { create(:project) }
    let(:project_id) { project.id }
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
      create(:collaboration, project: project, collaborator: current_user)
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
