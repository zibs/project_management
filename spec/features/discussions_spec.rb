require 'rails_helper'

RSpec.feature "Discussions", type: :feature do
  let!(:user){create(:user)}
  let!(:project){create(:project)}

  describe "create discussion" do

    context "with valid discussion params" do
      before { log_in_via_web(user) }
      it "renders the new discussion, and displays a flash message" do

        valid_discussion = attributes_for(:discussion)
        visit project_path(project)
        fill_in "discussion_title", with: valid_discussion[:title]
        fill_in "discussion_body", with: valid_discussion[:body]

        # fill_in "task_due_date", with: valid_task[:due_date]
        click_button "add discussion"
        expect(current_path).to eq(discussion_path(Discussion.last))
        expect(page).to have_text  /Discussion Initialized/i
      end
    end
    context "with invalid params" do
      before { log_in_via_web(user) }
      it "renders an error, and displays a flash message" do

        visit project_path(project)
        fill_in "Title", with: ""
        click_button "Create Task"

        expect(current_path).to eq(project_discussions_path(project))
        expect(page).to have_text /error/

      end
    end
    context "unathenticated" do
      it "redirects to the new session path" do
        visit project_path(project)

        expect(current_path).to eq(new_session_path)
      end
    end
    # end create
  end
end
