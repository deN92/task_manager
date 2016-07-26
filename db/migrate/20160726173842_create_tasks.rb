class CreateTasks < ActiveRecord::Migration
	def change
		create_table :tasks do |t|
			t.integer :user_id, limit: 3, null: false
			t.string  :task_name, limit: 200, null: false
			t.string  :task_desc, limit: 2000, null: false
			t.timestamps null: false
		end
	end
end