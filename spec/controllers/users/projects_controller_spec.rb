require 'spec_helper'

describe Users::ProjectsController do
  render_views

  describe '#create' do
    let(:current_user) { create(:user) }
    let(:company) { Faker::Company.name }
    let(:title) { Faker::Commerce.product_name }
    let(:media_url) { Faker::Internet.url }
    let(:contribution) { 'I made this' }
    let(:start_at) { Date.yesterday }
    let(:project_params) { {
      company: Faker::Company.name,
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
      before_action
      sign_in(current_user)
      action_response
    }
    subject { action_response }



    context 'when project data is valid' do

      context 'when user has less than min projects per user' do
        it { should redirect_to(users_feeds_path) }
      end # when user has min projects per user

    end # when project data is valid

    context 'when project data is invalid' do
      let(:title) { '' }
      it { should render_template(:new) }
    end # when project data is invalid

  end # create

end
