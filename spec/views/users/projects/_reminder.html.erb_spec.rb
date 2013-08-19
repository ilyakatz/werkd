require 'spec_helper'

describe "users/projects/_reminder.html.erb" do

  let(:user){build(:user)}

  before do
    view.stub(:current_user).and_return(user)
  end

  it "should remind user to create projects" do
    user.stub_chain(:projects, :count).and_return(0)
    render
    rendered.should match("Let's add three")
  end

  it "should give a reminder for 'almost there' case" do
    user.stub_chain(:projects, :count).and_return(2)
    render
  end

  it "should give a reminder for 'good start' case" do
    user.stub_chain(:projects, :count).and_return(1)
    render
    rendered.should match("Only two more left")
  end

  it "should be quiet if everything is done" do
    user.stub_chain(:projects, :count).and_return(3)
    render
    rendered.should eq ""
  end

end


