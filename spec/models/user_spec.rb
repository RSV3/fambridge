require 'spec_helper'

describe User do

  before do
    @user = User.new(first_name: "Example User", email: "user@example.com", 
                    password: "passage", password_confirmation: "passage")
  end

  subject { @user }

  it { should respond_to(:first_name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:primary)}
  it { should respond_to(:super_admin) }
  it { should respond_to(:feeds) }

  it { should be_valid }
  it { should_not be_super_admin }

  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end

  describe "with admin attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:super_admin)
    end

    it { should respond_to(:super_admin)}
    it { should be_super_admin }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "with invalid password" do
    before { @user.save }

    let(:found_user) { User.find_by(email: @user.email) }
    let(:user_for_invalid_password) { found_user.authenticate("invalid") }

    it { should_not eq user_for_invalid_password }
    specify { expect(user_for_invalid_password).to be_false }
  end

  
  describe "feed associations" do
    before { @user.save }
    let!(:older_feed) do
      FactoryGirl.create(:feed, author: @user, created_at: 1.day.ago)
    end
    let!(:newer_feed) do
      FactoryGirl.create(:feed, author: @user, created_at: 1.hour.ago)
    end

    it "should have the right feeds in the right order" do
      expect(@user.feeds.to_a).to eq [newer_feed, older_feed]
    end

    it "should destroy associated feeds" do
      # copy the feeds 
      feeds = @user.feeds.to_a
      # destroy user
      @user.destroy
      expect(feeds).not_to be_empty
      feeds.each do |feed|
        expect(Feed.where(id: feed.id)).to be_empty
      end
    end   

    describe "status" do
      let(:unfollowed_post) do
        FactoryGirl.create(:feed, author: FactoryGirl.create(:user))
      end

      # uses User.feed action
      its(:myfeed) { should include(newer_feed) }
      its(:myfeed) { should include(older_feed) }
      its(:myfeed) { should_not include(unfollowed_post)}
    end
  end

  describe "has care receiver" do
  end

  describe "has secondary care givers" do
  end

  describe "is the secondary care giver, refer to care receiver" do
  end

  describe "is the secondary care giver, refer to primary care giver" do
  end

  describe "comments" do
    it "should destroy associated comments" do
    end
  end
end
