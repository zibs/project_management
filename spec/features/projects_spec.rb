require 'rails_helper'

RSpec.feature "Projects", type: :feature do
  let!(:user){create(:user)}

  describe "index" do
    it "displays the text `Current Projects` on it" do
      visit root_path
      # expect(page).to have_text /current posts/i
      expect(page).to have_selector "h1", text: /All Projects/i
    end
    # end index
  end

  describe "create project" do

    context "with valid post params" do
      before { log_in_via_web(user) }
      it "renders the new post's page, and displays a flash message" do

        valid_project = attributes_for(:project)
        visit new_project_path

        fill_in "Title", with: valid_project[:title]
        fill_in "Description", with: valid_project[:description]
        click_button "Add Project"
        expect(current_path).to eq(project_path(Project.last))
        expect(page).to have_text  /added/i
      end
    end
    context "with invalid params" do
      before { log_in_via_web(user) }
      it "renders an error, and displays a flash message" do

        visit new_project_path
        fill_in "Title", with: ""
        click_button "Add Project"

        expect(current_path).to eq(projects_path)
        expect(page).to have_text /unsuccessfully/

      end
    end
    context "unathenticated" do
      it "redirects to the new session path" do
        visit new_project_path
        expect(current_path).to eq(new_session_path)
      end
    end
    # end create
  end
  # end rspec
end
