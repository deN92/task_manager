class TaskusersController < ApplicationController
	def create
		user = User.where(email: params[:taskuser][:user_id]).first
		if (user.nil? || Taskuser.where(task_id: params[:taskuser][:task_id]).map(&:user_id).include?(current_user.id) == false)
			respond_to do |format|
				format.html { redirect_to :back, alert: 'Task was not sent'}
			end
		else
			Taskuser.create(user_id: user.id, task_id: params[:taskuser][:task_id])
			UserMailer.welcome_email(user).deliver_now
			respond_to do |format|
				format.html { redirect_to root_path, notice: 'Task was successfully sent' }
			end
		end
	end
end
