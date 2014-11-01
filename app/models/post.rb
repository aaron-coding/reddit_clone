# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  url        :string(255)      not null
#  content    :string(255)
#  author_id  :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Post < ActiveRecord::Base
  validates :title, :url, :author, presence: true

  belongs_to(
    :author,
    class_name: "User", 
    foreign_key: :author_id
  )
  
  has_many(
    :comments,
    class_name: "Comment",
    foreign_key: :post_id
  )
  
  has_many(
    :top_level_comments,
    -> { where("parent_comment_id IS NULL" ) },
    class_name: "Comment"
  )

  has_many :post_subs, inverse_of: :post, dependent: :destroy
  has_many :subs, through: :post_subs, source: :sub
end
