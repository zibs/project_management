require 'rails_helper'

RSpec.feature "Users", type: :feature do

    describe "Sign Up" do
    context "with valid information" do
      it "redirects to the homepage / displays user name on the page / displays `account created` flash message" do
        visit new_user_path
        # method that can fill in specific text boxes with information. Takes in the text on the label, or the ID of the field. ID is more reliable as it less likely to change, but we have to know what it is.
        valid_user_attributes = FactoryGirl.attributes_for(:user)
        fill_in "First name", with: valid_user_attributes[:first_name]
        fill_in "Last name", with: valid_user_attributes[:last_name]
        fill_in "Email", with: valid_user_attributes[:email]
        fill_in "Password", with: valid_user_attributes[:password]
        fill_in "Password confirmation", with: valid_user_attributes[:password]
        # click button will trigger the submit button associated to a form
        # save_and_open_page
        click_button "Create Account"
        user_full_name = "#{valid_user_attributes[:first_name]} #{valid_user_attributes[:last_name]}"

        expect(current_path).to eq(root_path)
        expect(page).to have_text /edit profile/i
        expect(page).to have_text /User created/i
      end
    end

    context "with invalid information" do
      it "rerenders the form with error messages and sets a flash fail message" do
        visit new_user_path
        fill_in "user_first_name", with: "John"
        click_button "Create Account"

        expect(page).to have_text /errors/i
        expect(page).to_not have_text /edit_profile/i

      end
    end

  end
end
