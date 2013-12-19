require 'spec_helper'

describe "MainPages" do

  subject {page}

  describe "Home page" do

    let(:user) { FactoryGirl.create(:user) }

    before do
      FactoryGirl.create(:feed, author: user, content: "Lorem ipsum")
      FactoryGirl.create(:feed, author: user, content: "Dolor sit amet")
      sign_in user
      visit root_path
    end

    it "should render the user's feed" do
      user.feeds.each do |item|
        expect(page).to have_selector("li##{item.id}", text: item.content)
      end
    end
  end

end
