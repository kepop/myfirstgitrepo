class Page < ActiveRecord::Base
  ## Relation / Associations
  belongs_to :subject
  has_many :sections
  #has_and_belongs_to_many :admin_users
  #has_and_belongs_to_many :admin_users, :join_table => "admin_users_pages"
  has_and_belongs_to_many :editors, :class_name => "AdminUser"

  ## Scopes
  scope :visible, lambda {where({:visible => true})}
  scope :invisible, lambda {where({:visible => false})}
  scope :sorted, lambda {order("pages.position ASC")}
  scope :newest_first, lambda {order("pages.created_at DESC")}

  scope :search, lambda {|query|
    where(["name LIKE ?", "%#{query}%"])
  }  

  # ## Validations
  # validates_presence_of :name
  # validates_length_of   :name, :maximum => 255
  # validates_presence_of :permalink
  # validates_length_of   :permalink, :within => 3..255
  # ## use validates_presence_of with validates_length_of to disallow spaces
  
  # validates_uniqueness_of :permalink
  # ## for unique value of permalink within a subject use ":scope => subject_id"

  ## Shortcut Validations (a.k.a. Sexy Validations)
  validates :name, :presence => true,
                   :length => {:maximum => 255}
  validates :permalink, :presence => true,
                        :length => {:within => 3..255},
                        :uniqueness => true

end
