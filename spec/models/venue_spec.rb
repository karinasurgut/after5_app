require 'spec_helper'

describe Venue do

  before do
  	@venue = Venue.new(name: "Example Venue", email: "venue@example.com", 
  							  phone: "1234567890", street: "1 Example Street", suburb: "Example Suburb", 
  							  region: "Inner Example Region", website: "http://www.example.com", 
  							  postcode: "1111")
  end

  subject { @venue }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:phone) }
  it { should respond_to(:street) }
  it { should respond_to(:suburb) }
  it { should respond_to(:region) }
  it { should respond_to(:website) }

  it { should be_valid }

  describe "when name is not present" do
  	before { @venue.name = " " }
  	it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @venue.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when name is too short" do
    before { @venue.name = "a" }
    it { should_not be_valid }
  end

  describe "when street is not present" do
  	before { @venue.street = " " }
  	it { should_not be_valid }
  end

  describe "when street is too long" do
    before { @venue.street = "a" * 51 }
    it { should_not be_valid }
  end
  
  describe "when suburb is not present" do
  	before { @venue.suburb = " " }
  	it { should_not be_valid }
  end

  describe "when suburb is too long" do
    before { @venue.suburb = "a" * 21 }
    it { should_not be_valid }
  end

  describe "when phone is not present" do
  	before { @venue.phone = " " }
  	it { should_not be_valid }
  end

  describe "when phone is too long" do
    before { @venue.phone = "1" * 13 }
    it { should_not be_valid }
  end

  describe "when postcode is not present" do
  	before { @venue.postcode = " " }
  	it { should_not be_valid }
  end

  describe "when postcode is too long" do
    before { @venue.postcode = "1" * 5 }
    it { should_not be_valid }
  end

  describe "when postcode is too short" do
    before { @venue.postcode = "1" * 3 }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @venue.email = invalid_address
        expect(@venue).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @venue.email = valid_address
        expect(@venue).to be_valid
      end
    end
  end

  #add website regex validation!!

  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it "should be saved as all lower-case" do
      @venue.email = mixed_case_email
      @venue.save
      expect(@venue.reload.email).to eq mixed_case_email.downcase
    end
  end
 end