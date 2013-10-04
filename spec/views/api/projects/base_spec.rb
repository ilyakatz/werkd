require 'spec_helper'

describe 'api/projects/base.rabl' do

  context 'regular project' do
    let(:project) { create(:project) }
    let(:rendered_view) { Rabl.render(project, 'api/projects/base', view_path: 'app/views', format: :hash) }
    subject { rendered_view }
    it { should be }
    it 'should have attributes' do
      subject[:id].should == project.id
      subject[:title].should == project.title
      subject[:thumbnail_url].should == project.thumbnail_url
      subject[:cloudinary_id].should == project.cloudinary_id
      subject[:embed_html].should == project.embed_html
    end
  end

end
