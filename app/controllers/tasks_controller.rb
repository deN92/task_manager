class TasksController < ApplicationController
  
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
    @users = User.order("id")
    @taskuser = Taskuser.new
  end

  def show
  	render text: "404" unless user_signed_in?
  	render text: "404" unless @task.taskusers.map(&:user_id).include?(current_user.id)
  end

  def new
    if user_signed_in? 
    	@task = Task.new
    else render text: 404
    end
  end

  def edit
  	render text: 404 unless @task.taskusers.map(&:user_id).include?(current_user.id)
  end

 def create
    @task = Task.new(task_params)
    if Taskuser.count == 0
    	Taskuser.create(user_id: current_user.id, task_id: 1)
    else
    	Taskuser.create(user_id: current_user.id, task_id: Task.last.id + 1)
    end
    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

	def destroy
		if (user_signed_in? && @task.author == current_user.email)
			@task.destroy
			respond_to do |format|
				format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
				format.json { head :no_content }
			end
		end
	end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:task_name, :task_desc).merge(author: current_user.email)
    end
end
