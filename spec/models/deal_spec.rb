require 'spec_helper'

describe Deal do

  let(:venue) { FactoryGirl.create(:venue) }
  before { @deal = venue.deals.build(title: "5 Dollar Beers All Day",
  									 content: "Lorem ipsum") }

  subject { @deal }
  
  it { should respond_to(:title) }
  it { should respond_to(:content) }
  it { should respond_to(:venue_id) }
  it { should respond_to(:venue) }
  its(:venue) { should eq venue }

  it { should be_valid }

  describe "when venue_id is not present" do
    before { @deal.venue_id = nil }
    it { should_not be_valid }
  end

  describe "with blank title" do
    before { @deal.title = " " }
    it { should_not be_valid }
  end
  
  describe "with content that is too long" do
    before { @deal.content = "a" * 141 }
    it { should_not be_valid }
  end
end