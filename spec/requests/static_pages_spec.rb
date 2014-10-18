require 'spec_helper'

describe "Static pages" do

  let(:base_title) { "After5" }

  describe "Home page" do

    it "should have the content 'After5'" do
      visit root_path
      expect(page).to have_content('After5')
    end

    it "should have the title 'Home'" do
      visit root_path
      expect(page).to have_title("#{base_title} | Home")
    end
  end

  describe "Terms page" do

    it "should have the content 'Terms'" do
      visit terms_path
      expect(page).to have_content('Terms & Conditions')
    end

    it "should have the title 'Terms'" do
      visit terms_path
      expect(page).to have_title("#{base_title} | Terms &amp; Conditions")
    end
  end

  describe "About page" do

    it "should have the content 'About'" do
      visit about_path
      expect(page).to have_content('About')
    end

    it "should have the title 'About'" do
      visit about_path
      expect(page).to have_title("#{base_title} | About")
    end
  end

  describe "Contact page" do

    it "should have the content 'Contact'" do
      visit contact_path
      expect(page).to have_content('Contact Us')
    end

    it "should have the title 'Contact Us'" do
      visit contact_path
      expect(page).to have_title("#{base_title} | Contact Us")
    end
  end
end
