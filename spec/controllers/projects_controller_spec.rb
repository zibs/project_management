require 'rails_helper'

RSpec.describe ProjectsController, :type => :controller do
  # before many actions in Post, we will need to sign in.
  # let(:blogpost){create(:post)}
  let(:user){create(:user)}

   context "authenticated user" do
      before { log_in(user) }

      describe "#new" do

        it "renders the new template" do
          get :new
          expect(response).to render_template(:new)
        end

        it "instantiates a new Post object" do
          get :new
          expect(assigns(:project)).to be_a_new(Project)
        end
      end
      
      describe "#create" do
        context "with valid parameters" do
          let(:project_attributes){attributes_for(:project)}

          def send_valid_request
            post :create, { project: project_attributes }
          end

          it "creates a post record in the database" do
            expect{send_valid_request}.to change{Project.count}.by(1)
          end
          it "associates the post with a user" do
            send_valid_request
                      # expect(Post.last.user_id).to eq(user.id)
            expect(Project.last.user_id).to eq(user.id)
          end

          it "sets a flash message" do
            send_valid_request
            expect(flash[:success]).to be
          end

          it "redirects to the posts show" do
            send_valid_request
            expect(response).to redirect_to(project_path(Project.last))
        end
      end

      context "with invalid parameters" do
          def send_invalid_request
            post :create, project: attributes_for(:project, {title: nil} )
          end

          it "doesn't create a record in the database" do
            expect{send_invalid_request}.to_not change{Project.count}
          end
          it "renders the new template" do
            send_invalid_request
            expect(response).to render_template(:new)
          end
          it "sets a flash message" do
            send_invalid_request
            expect(flash[:warning]).to be
          end
      end
    end

    describe "#edit" do
      context "unauthorized user" do
        let(:user_two){create(:user)}
        let(:project){create(:project, user_id: user_two)}
        it "cannot edit another's post" do
          get :edit, id: project
          expect(response).to redirect_to(root_path)
        end
        it "sets a flash message" do
          get :edit, id: project
          expect(flash[:info]).to be
        end

      end

      context "with valid attributes" do
        # this is not hitting the controller so its not making the association

        let(:project_attributes){attributes_for(:project)}

        before do
          @project = user.projects.create(project_attributes)
        end

        it "renders edit" do
          get :edit, id: @project
          expect(response).to render_template(:edit)
        end
      end
    end

    describe "#update" do
      context "unauthorized user" do
        let(:user_two){create(:user)}
        let(:project){create(:project, user_id: user_two.id)}
        it "cannot update someone else's blogpost" do
          patch :update, id: project, project: {title: ""}
          expect(response).to redirect_to(root_path)
        end
        it "sets a flash message" do
          patch :update, id: project, project: {title: ""}
          expect(flash[:info]).to be
        end

      end
      context "with valid attributes" do
        let!(:project){create(:project, user_id: user.id)}

        def update_project
          # @project = user.projects.create(title: "abcdefghijk")
          patch :update, id: project, project: { title: "123123123"}
          # binding.pry
        end
      #
        it "updates the attributes with the parameters" do
          update_project
          expect(project.reload.title).to eq("123123123")
        end
        it "redirects to user page after successful update" do
          update_project
          expect(response).to redirect_to(project_path(project))
        end
      end

      context "without valid attributes" do
        let!(:project){create(:project, user_id: user.id)}
        def update_invalid_blogpost
          patch :update, id: project, project: { title: ""}
        end

        it "doesn't update the record in the database" do
          update_invalid_blogpost
          expect(project.reload.title).to eq(project.title)
        end

        it "renders the edit template" do
          update_invalid_blogpost
          expect(response).to render_template(:edit)
        end
      end
    end

    describe "#destroy" do

      context "unauthorized user" do
        let!(:user_two){create(:user)}
        let!(:project){create(:project, user_id: user_two)}

        it "cannot delete another user's project" do
          delete :destroy, id: project
          expect(response).to redirect_to(root_path)
        end
        it "sets a flash message" do
          delete :destroy, id: project
          expect(flash[:info]).to be
        end
      end
      context "authorized user" do
      let!(:firstproject){create(:project, user_id: user.id)}
      let!(:project){create(:project, user_id: user.id)}

      def delete_project
        delete :destroy, id: project
       end

       it "removes the record from the database" do
         expect{delete_project}.to change{Project.count}.by(-1)
       end

       it "redirects to the index template" do
         delete_project
         expect(response).to redirect_to(root_path)
       end

       it "sets a flash message upon deletion" do
         delete_project
         expect(flash[:danger]).to be
       end
     end

    end

  end

  context "unauthenticated user" do
     let(:project){create(:project)}
     describe "#new" do
       it "redirects to sign in page" do
         get :new
         expect(response).to redirect_to(new_session_path)
       end
     end

     describe "#create" do
       it "redirects to sign in page" do
         post :create, project:project
         expect(response).to redirect_to(new_session_path)
       end
     end

     describe "#edit" do
       it "redirects to sign in page" do
         get :edit, id: project
         expect(response).to redirect_to(new_session_path)
       end
     end

     describe "#update"
       it "redirects to sign in page" do
         patch :update,id: project, project: { title: ""}
       end
     describe "#destroy" do
     let!(:project){create(:project)}
       it "redirects to the sign in page" do
         delete :destroy, id: project
         expect(response).to redirect_to(new_session_path)
       end
     end

     describe "#index" do
       it "renders the index template" do
         get :index
         expect(response).to render_template(:index)
       end
       # it "paginates the posts" do
         # get :index
         # expect(assigns).to
       # end
     end

     describe "#show" do
     let(:project){create(:project)}
       it "renders the show template" do
         get :show, id: project
         expect(response).to render_template(:show)
       end
     end
   end
 end
