require 'spec_helper'

describe Feed do

  let(:user) { FactoryGirl.create(:user) }
  before do
    @feed = user.feeds.build(title: "Lorem by John", content: "Lorem ipsum", content_type: "Activity", 
                    content_img: "http://upload.wikimedia.org/wikipedia/commons/7/7d/Elderly_Woman_,_B%26W_image_by_Chalmers_Butterfield.jpg",
                    content_url: "http://commons.wikimedia.org/wiki/File:Elderly_Woman_,_B%26W_image_by_Chalmers_Butterfield.jpg")
  end

  subject { @feed }

  it { should respond_to(:content) }
  it { should respond_to(:content_type) }
  it { should respond_to(:content_img) }
  it { should respond_to(:content_url) }
  it { should respond_to(:author_id) }
  it { should respond_to(:author) }
  its(:author) { should eq user }

  it { should be_valid }

  describe "when author_id is not present" do
    before { @feed.author_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @feed.content = " " }
    it { should_not be_valid }
  end

  describe "with title is too long" do
    before { @feed.title = "a" * 201 }
    it { should_not be_valid }
  end
end
