# == Schema Information
#
# Table name: comments
#
#  id                :integer          not null, primary key
#  content           :string(255)      not null
#  author_id         :integer          not null
#  post_id           :integer          not null
#  created_at        :datetime
#  updated_at        :datetime
#  parent_comment_id :integer
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
  
  belongs_to(
    :parent_comment,
    class_name: "Comment",
    foreign_key: :parent_comment_id,
    primary_key: :id
  )
  
  has_many(
    :child_comments,
    class_name: "Comment",
    foreign_key: :parent_comment_id,
    primary_key: :id
  )
  
end
