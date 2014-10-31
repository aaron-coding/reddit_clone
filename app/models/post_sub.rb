# == Schema Information
#
# Table name: post_subs
#
#  id         :integer          not null, primary key
#  post_id    :integer          not null
#  sub_id     :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class PostSub < ActiveRecord::Base
  validates :sub, :post, presence: true
  validates :sub, uniqueness: { scope: :post }
  
  belongs_to :sub
  belongs_to :post
end
