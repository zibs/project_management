require 'rails_helper'

RSpec.describe ProjectsController, :type => :controller do
  let(:project) { FactoryGirl.create(:project)}

  describe "#new" do
    before do
      get :new
    end
    it "renders the new template" do
      expect(response).to render_template(:new)
    end

    it "instantiates a new project object and assigns it to an instance variable" do
      expect(assigns(:project)).to be_a_new(Project)
    end
  end

  describe "#create" do

    context "with valid attributes" do

      def valid_post_request
        post :create, project: { title: "valied tit dsle yahoo", description: "superd great edscirpsad dtion", due_date: "0000"}
      end

      it "should create a record in the database" do
        db_before = Project.count
        valid_post_request
        expect(Project.count).to eq(db_before + 1)
      end

      it "should redirect to the show action" do
        valid_post_request
        expect(response).to redirect_to(project_path(Project.last))
      end

      it "should set a flash notice message" do
        valid_post_request
        expect(flash[:notice]).to be
      end
    end

     context "with invalid attributes" do
       def invalid_post_request
         post :create, project: { title: "", description: "", due_date: ""}
       end

       it "should not save to the database" do
         db_count = Project.count
         invalid_post_request
         expect(Project.count).to eq(db_count)
       end

       it "should render the new template" do
         invalid_post_request
         expect(response).to render_template(:new)
       end

       it "should set a flash alert" do
         invalid_post_request
         expect(flash[:alert]).to be
       end
     end
   end

  describe "#show" do
    before do
        get :show, id: project
    end

    it "renders the new template" do
      expect(response).to render_template(:show)
    end

    it "finds the object and assigns it to an instance variable" do
      expect(assigns(:project)).to eq(project)
    end

    it "raises an ActiveRecord error if the ID doesn't exist" do
      expect { get :show, id: 123123123 }.to raise_error(ActiveRecord::RecordNotFound)
    end

  end

  describe "#edit" do
    before do
      get :edit, id: project.id
    end

    it "renders the edit page" do
      expect(response).to render_template(:edit)
    end

    it "assigns an instance variable to the associated ID" do
      expect(assigns(:project)).to eq(project)
    end
  end

  describe "#update" do
    context "with valid attributes" do

      before do
        patch :update, id: project, project: { title: "abcdefghidjk" }
      end

      it "redirects to show upon successful update" do
        expect(response).to redirect_to(project_path(project))
      end

      it "updates the record with the new parameters" do
        expect(project.reload.title).to eq(project.title)
      end

      it "sets a flash message" do
        expect(flash[:notice]).to be
      end
    end

    context "with invalid attributes" do
      before do
        patch :update, id: project, project: { title: "" }
      end

        it "renders the edit template after bad input" do
          expect(response).to render_template(:edit)
        end

        it "does not save the record to the database" do
          expect(project.reload.title).to eq(project.title)
        end

        it "displays a flash message for bad input" do
          expect(flash[:alert]).to be
        end
    end
  end

  describe "#destroy" do
    let!(:project){FactoryGirl.create(:project)}

      def delete_project
        delete :destroy, id: project
      end

      it "removes the record from the database" do
        expect{delete :destroy, id: project}.to change{Project.count}.by(-1)
      end

      it "redirects to the index template" do
        delete :destroy, id: project
        expect(response).to redirect_to(root_path)
      end

      it "sets a flash message upon deletion" do
        delete :destroy, id: project
        expect(flash[:alert]).to be
      end

  end

end
