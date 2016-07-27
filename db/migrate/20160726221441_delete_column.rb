class DeleteColumn < ActiveRecord::Migration
	def change
		remove_column :tasks, :user_id
	end
end
