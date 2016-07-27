require 'rails_helper'
require "spec_helper"

RSpec.describe TasksController, type: :controller do

	describe "index" do		
		it "render_index" do
			get :index
			response.should render_template('index')
		end
	end

	describe "show" do		
		
		it "render_show" do
			@request.env["devise.mapping"] = Devise.mappings[:user]
			current_user = FactoryGirl.create(:user)
			sign_in current_user
			task = FactoryGirl.create(:task)
			FactoryGirl.create(:taskuser)
			get :show, {id: task.id}
			response.should render_template('show')
		end

		it "render_404" do
			@request.env["devise.mapping"] = Devise.mappings[:user]
			current_user = FactoryGirl.create(:user)
			sign_in current_user
			task = FactoryGirl.create(:task)
			get :show, {id: task.id}
			response.status.should == 200
		end
	end

	module MacrosComments
		def test_comments(v1, v2)
			@request.env["devise.mapping"] = Devise.mappings[:user]
			current_user = FactoryGirl.create(:user)
			sign_in current_user
			post :create, task: {author: "task.author", task_name: "task.task_name", task_desc: v1}
			(Task.all.count).should == v2
		end
	end

	describe "create" do

		before(:each) do
			request.env["HTTP_REFERER"] = "redirect_to_back"
		end

		it "create_true" do
			extend MacrosComments
			test_comments("qwe 1q2w3e4r",1)
		end

		it "create_false" do
			extend MacrosComments
			test_comments("",0)
		end
	end


end
