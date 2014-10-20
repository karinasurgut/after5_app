require 'spec_helper'

describe "Deal pages" do

  subject { page }

  #let(:user) { FactoryGirl.create(:user) }
  #before { sign_in user }

  describe "deal creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a deal" do
        expect { click_button "Create Deal" }.not_to change(Deal, :count)
      end

      describe "error messages" do
        before { click_button "Create Deal" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before do 
      	fill_in 'deal_venue', with: "1"
      	fill_in 'deal_title', with: "Lorem ipsum Beer Day"
      	fill_in 'deal_content', with: "Lorem ipsum"
      end
      it "should create a deal" do
        expect { click_button "Create Deal" }.to change(Deal, :count).by(1)
      end
    end
  end

  describe "deal destruction" do
    #before { FactoryGirl.create(:deal, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a deal" do
        expect { click_link "delete" }.to change(Deal, :count).by(-1)
      end
    end
  end
end