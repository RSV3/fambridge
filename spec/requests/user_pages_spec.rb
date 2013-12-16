require 'spec_helper'

describe 'User pages'  do
  subject { page }  

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.first_name) }
    it { should have_title(user.first_name) }
  end

  describe "signup invalid user data" do

    let(:submit) {"Create my account"}
    before do 
      visit signup_path

      fill_in "First name", with: "Janet Jackson"
      fill_in "Email", with: ""
      fill_in "Password", with: ""
      fill_in "Password confirmation", with: ""
    end

    it "should not create user" do
      expect do
        click_button submit 
      end.not_to change(User, :count)
    end
  end

  describe "signup valid user data" do

    let(:submit) {"Create my account"}
    before do
      visit signup_path

      fill_in "First name", with: "Janet Jackson"
      fill_in "Email", with: "jackson@gmail.com"
      fill_in "Password", with: "janetjack"
      fill_in "Password confirmation", with: "janetjack"
      
    end

    it "should create user" do
      expect do
        click_button submit 
      end.to change(User, :count).by(1)
    end
  end
end