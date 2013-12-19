require 'spec_helper'

describe 'User pages'  do
  subject { page }  


  describe "index" do
    let(:user) { FactoryGirl.create(:admin) }

    before(:each) do
      sign_in user 
      visit users_path
    end

    it { should have_title('User management') }
    it { should have_content('All users') }

    describe "pagination" do
      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all) { User.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.first_name)
        end
      end
    end

    describe "delete links" do
      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('delete', href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect do
            click_link('delete', match: :first)
          end.to change(User, :count).by(-1)
        end

        it { should_not have_link('delete', href: user_path(admin)) }
      end

    end

  end

  describe "family page" do

    let(:user) { FactoryGirl.create(:user) }

    before do
      sign_in user
      visit family_path
    end

    it { should have_title(full_title('Family Members')) }
    it { should have_content(user.first_name) }
  end

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:m1) { FactoryGirl.create(:feed, author: user, title: "Great by John", 
                                          content: "Fooleo barlio") }
    let!(:m2) { FactoryGirl.create(:feed, author: user, title: "Barlio foolea",
                                          content: "Barrilo fooleate") }

    before do
      # made profile page only accessible after sign in
      sign_in user
      visit user_path(user)
    end

    it { should have_content(user.first_name) }
    it { should have_title(user.first_name) }

    describe "feeds" do
      it { should have_content(m1.content) }
      it { should have_content(m2.content) }
      it { should have_content(user.feeds.count) }
    end
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
      fill_in "Email", with: "user@example.com"
      fill_in "Password", with: "janetjack"
      fill_in "Password confirmation", with: "janetjack"
      
    end

    it "should create user" do
      expect do
        click_button submit 
      end.to change(User, :count).by(1)
    end

    describe "after saving the user" do
      before { click_button submit }
      let(:user) { User.find_by(email: "user@example.com") }

      it { should have_link('Sign out') }
      it { should have_title(user.first_name) }
      it { should have_selector('div.alert.alert-success', text: 'Welcome') }
    end
  end

  describe "update settings" do

    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_content("Update your settings") }
      it { should have_title("Settings of") }
      it { should have_link("change", href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content('valid values') }
    end

    describe "with valid information" do
      let (:new_first_name) { "NewFirstName" }
      let (:new_last_name) { "NewLastName" }
      let (:new_email) { "new@example.com" }

      before do
        fill_in "First name", with: new_first_name
        fill_in "Last name", with: new_last_name
        fill_in "Email", with: new_email
        fill_in "Password", with: user.password
        fill_in "Confirm Password", with: user.password
        click_button "Save changes"
      end

      it { should have_title(new_first_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { expect(user.reload.first_name).to eq new_first_name }
      specify { expect(user.reload.email).to eq new_email }
    end

  end
end