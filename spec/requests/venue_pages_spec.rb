require 'spec_helper'

describe "VenuePages" do

  subject { page }

  describe "venue page" do
    let(:venue) { FactoryGirl.create(:venue) }
    before { visit venue_path(venue) }

    it { should have_content(venue.name) }
    it { should have_title(venue.name) }
  end

  describe "new venue page" do
    before { visit new_venue_path }

    it { should have_content('Add Venue') }
    it { should have_title(full_title('Add Venue')) }
  end

  describe "new venue creation" do

    before { visit new_venue_path }

    let(:submit) { "Create Venue" }

    describe "with invalid information" do
      it "should not create a venue" do
        expect { click_button submit }.not_to change(Venue, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_title('Add Venue') }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before do
        fill_in "Venue Name",       with: "Awesome Bar"
        fill_in "Phone",         	with: "0412345678"
        fill_in "Website",         	with: "http://www.example.com"
        fill_in "Email",         	with: "venue@example.com"
        fill_in "Street Address",   with: "23 King Street"
        fill_in "Suburb",         	with: "Newtown"
        fill_in "Postcode",         with: "2042"
        fill_in "Area",         	with: "Inner West"
      end

      it "should create a venue" do
        expect { click_button submit }.to change(Venue, :count).by(1)
      end

      describe "after saving the venue" do
        before { click_button submit }
        let(:venue) { Venue.find_by(name: 'Awesome Bar') }

        it { should have_title(venue.name) }
        #it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
    end
  end

  describe "edit" do
    let(:venue) { FactoryGirl.create(:venue) }
    before { visit edit_venue_path(:venue) }

    describe "page" do
      it { should have_content("Edit Venue") }
      it { should have_title("Edit Venue") }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_phone) { "01101010100" }
      let(:new_website)  { "http://www.new.com" }
      let(:new_email) { "new@example.com" }
      let(:new_street)  { "New Street 13" }
      let(:new_suburb) { "New Newtown" }
      let(:new_postcode)  { "9292" }
      let(:new_area) { "New inner west" }

      before do
        fill_in "Venue Name",       with: new_name
        fill_in "Phone",         	with: new_phone
        fill_in "Website",         	with: new_website
        fill_in "Email",         	with: new_email
        fill_in "Street Address",   with: new_street
        fill_in "Suburb",         	with: new_suburb
        fill_in "Postcode",         with: new_postcode
        fill_in "Area",         	with: new_area
        click_button "Save changes"
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      specify { expect(venue.reload.name).to  eq new_name }
      specify { expect(venue.reload.phone).to  eq new_phone }
      specify { expect(venue.reload.website).to  eq new_website }
      specify { expect(venue.reload.email).to  eq new_email }
      specify { expect(venue.reload.street).to  eq new_street }
      specify { expect(venue.reload.suburb).to  eq new_suburb }
      specify { expect(venue.reload.postcode).to eq new_postcode }
      specify { expect(venue.reload.area).to eq new_area }
    end
  end
end
