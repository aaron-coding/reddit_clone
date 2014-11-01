# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :string(255)      not null
#  author_id  :integer          not null
#  post_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Comment < ActiveRecord::Base
  validates :content, :author, :post, presence: true
  
  
  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :author_id
  )
  
  belongs_to(
    :post,
    class_name: "Post",
    foreign_key: :post_id
  )
end
