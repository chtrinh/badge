require 'spec_helper'

describe User do
  before(:each) do
    @attr = { :name => "Example User", :email => "user@example.com",
              :password => "asdfasdf", :password_confirmation => "asdfasdf"}
  end
  
  describe "Admin attribute validation" do
    it "should return false when passing an admin attribute" do
      no_admin = User.new(@attr.merge(:admin => "true"))
      no_admin.admin.should be_false
    end
    
    it "should return true using single assigment" do
      is_admin = User.new(@attr)
      is_admin.admin = true
      is_admin.save
      is_admin.admin.should be_true
    end
  end

  describe "Name and email validations" do 
    it "should create a new instance given valid attributes" do
      User.create!(@attr)
    end

    it "should require a name" do
      no_name = User.new(@attr.merge(:name => ""))
      no_name.should_not be_valid
    end
  
    it "should require an email" do
      no_email = User.new(@attr.merge(:email => ""))
      no_email.should_not be_valid
    end
  
    it "should accept valid email addresses" do
      tests = %w[root@example.com LOOK_ME@foo.example.gov john.last@example.jp]
      tests.each do |test|
        valid_email_user = User.new(@attr.merge(:email => test))
        valid_email_user.should be_valid
      end
    end

    it "should reject invalid email addresses" do
      tests = %w[bar@foo,com user_at_foo.gov example.user@foo. example@example]
      tests.each do |test|
        invalid_email_user = User.new(@attr.merge(:email => test))
        invalid_email_user.should_not be_valid
      end
    end

    it "should reject duplicate email addresses" do
      User.create!(@attr)
      duplicate = User.new(@attr)
      duplicate.should_not be_valid
    end
  end
  
  describe "password validations" do
    it "should have a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).should_not be_valid
    end
    
    it "should have a matching confirmation password" do
      User.new(@attr.merge(:password => "asdf", :password_confirmation => "")).should_not be_valid
    end
    
    it "should reject invalid size password" do
      invalid = "a" * 4
      User.new(@attr.merge(:password => invalid, :password_confirmation => invalid)).should_not be_valid
    end
    
    it "should create a user given valid password attributes" do
      lambda do 
        User.create!(@attr)
      end.should change(User, :count).by(1)
    end
  end
  
  describe "password encryption" do
    before(:each) do
      @user = User.create!(@attr)
    end
    
    it "should be true if passwords match" do
      @user.has_password?(@attr[:password]).should be_true
    end
    
    it "should be false if passwords do not match" do
      @user.has_password?("invalided password").should be_false
    end
    
    describe "user authentication" do
      it "should return nil(no user) for mismatch password" do 
        wrong_password = User.auth(@attr[:email], "asdfa")
        wrong_password.should be_nil
      end
      
      it "should return nil(no user) for non-existent user" do 
        fake_user = User.auth("JOHHHHNNY", @attr[:password])
        fake_user.should be_nil
      end
      
      it "should return user model for correct user/password combo" do 
        correct_user = User.auth(@attr[:email],  @attr[:password])
        correct_user.should == @user
      end
    end
  end
  
  describe "friendship relationships" do
    before(:each) do
      @user = User.create!(@attr)
      @friend  = User.create!(@attr.merge(:email => "asdff@agsf.com", :name => "Billy"))
    end
    
    it "should return user model from friend's friendship" do
      
      @user.add_friend(@friend)
      User.find(@friend.id).friendship_ids.include?(@user.id).should be_true
    end
    
    it "should return nil from friend's friendship" do
      @user.remove_friend(@friend)
      User.find(@user.id).friendship_ids.include?(@friend.id).should be_false
    end
  end
end
