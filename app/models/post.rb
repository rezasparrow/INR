class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments

	#def change
	#	create_table :posts do |t|
	#		t.string :text, :null => false, default => ""
	#		t.integer :INR, :null => false
	#	t.timestamps
	#end
	
end
