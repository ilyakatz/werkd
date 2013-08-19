require 'spec_helper'

describe "projects/_preview.html.erb" do

  let(:project){create(:project)}

  before do
    view.stub(:project).and_return(project)
  end

  context "view present" do

    before do
      project.stub(:embed_html).and_return("www.youtube.com/watch?v=ussCHoQttyQ")
      project.stub(:thumbnail_url).and_return("https://www.google.com/images/srpr/logo4w.pn")
    end

    it "should show thumbnail preview even if video is present" do
      render
      rendered.should match("https://www.google.com/images/srpr/logo4w.pn")
    end

    it "should show video preview" do
      render "projects/preview", show_video: true
      rendered.should match("www.youtube.com")
    end

  end

  it "should show image preview" do
    project.stub(:thumbnail_url).and_return("https://www.google.com/images/srpr/logo4w.pn")
    render
    rendered.should match("https://www.google.com/images/srpr/logo4w.pn")
  end

  it "should show default image" do
    render
    rendered.should match("werkd.png")
  end

end
