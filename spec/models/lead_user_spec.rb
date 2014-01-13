require 'spec_helper'

describe LeadUser do
  before { @user = LeadUser.new(first_name: "Dan", last_name: "Jogns", email: "dan@jogns.net", referrer: "http://localhost/savingstool") } 

  subject { @user }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:email) }
  it { should respond_to(:referrer) }

  describe "when last name is not present" do
    before do
      @user.first_name = "Jennifer"
      @user.last_name = ""
      @user.email = "jennifer@gmail.com"
    end

    it { should be_valid }
  end

  describe "when email is not present" do
    before do
      @user.first_name = "Jonathan"
      @user.last_name = "Farough"
      @user.email = ""
    end

    it { should_not be_valid }
  end

end
