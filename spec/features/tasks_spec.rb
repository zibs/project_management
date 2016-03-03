require 'rails_helper'

RSpec.feature "Tasks", type: :feature do
  let!(:user){create(:user)}
  let!(:project){create(:project)}

  describe "create task" do

    context "with valid task params" do
      before { log_in_via_web(user) }
      it "renders the new task, and displays a flash message" do

        valid_task = attributes_for(:task)
        visit project_path(project)
        fill_in "Title", with: valid_task[:title]

        # fill_in "task_due_date", with: valid_task[:due_date]
        click_button "Create Task"
        expect(current_path).to eq(project_path(project))
        expect(page).to have_text  /added/i
      end
    end
    context "with invalid params" do
      before { log_in_via_web(user) }
      it "renders an error, and displays a flash message" do

        visit project_path(project)
        fill_in "Title", with: ""
        click_button "Create Task"

        expect(current_path).to eq(project_tasks_path(project))
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
