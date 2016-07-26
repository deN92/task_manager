class Task < ActiveRecord::Base

	validates :user_id, :task_name, :task_desc, presence: true, uniqueness: true
	validates :task_desc, presence: true, uniqueness: true
	validates :task_name, length: { in: 5..200}
	validates :task_desc, length: { in: 5..2000}
	
	belongs_to :user

end