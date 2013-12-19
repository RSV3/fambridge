require 'spec_helper'

describe "FeedPages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "feed creation" do

    before { visit root_path }

    describe "with invalid information" do

      it "should not create a feed" do
        expect { click_button "Post" }.not_to change(Feed, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before { fill_in 'feed_content', with: "I just spoke with mom and talked about her bills." }
      it "should create a feed" do
        expect { click_button "Post" }.to change(Feed, :count).by(1)
      end
    end
  end

  describe "feed destruction" do
    before { FactoryGirl.create(:feed, author: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a feed" do
        expect { click_link "delete" }.to change(Feed, :count).by(-1)
      end
    end

  end

end
