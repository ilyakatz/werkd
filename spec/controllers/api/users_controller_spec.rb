require 'spec_helper'

describe Api::UsersController do
  render_views

  describe :show do
    let(:user) { create(:user) }
    let(:get_params) { {id: user.id} }
    let(:action_response) { get(:show, get_params) }
    subject { action_response }
    it { should be_success }

    context 'body' do
      let(:body) { action_response.body }
      subject { body }
      it { should match(/"id":/) }
    end # body

  end # show

end
