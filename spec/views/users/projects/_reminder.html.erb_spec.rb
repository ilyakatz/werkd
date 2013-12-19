require 'spec_helper'

describe "users/projects/_reminder.html.erb" do

  let(:user){build(:user)}

  before do
    view.stub(:current_user).and_return(user)
  end

  it "should remind user to create projects" do
    user.stub_chain(:projects, :count).and_return(0)
    render
    rendered.should match("Please add at least")
  end

  it "should be quiet if everything is done" do
    user.stub_chain(:projects, :count).and_return(3)
    render
    rendered.should eq "\n"
  end

end


