# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  url        :string(255)      not null
#  content    :string(255)
#  sub_id     :integer          not null
#  author_id  :integer          not null
#  created_at :datetime
#  updated_at :datetime


class Post < ActiveRecord::Base
  validates :title, :url, :author_id, :sub_id, presence: true
  
  belongs_to :sub
  belongs_to :author, class_name: "User", foreign_key: :author_id
  
  
end
