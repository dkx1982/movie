class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :groups
  has_many :posts
  has_many :group_relationships
  has_many :partpost_groups, :through => :group_relationships, :source => :group

  def is_member_of?(group)
    partpost_groups.include?(group)
  end

  def join!(group)
    partpost_groups << group
  end

  def quit!(group)
    partpost_groups.delete(group)
  end
end
