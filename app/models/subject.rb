class Subject < ActiveRecord::Base
  ## Relation / Associations
  #has_one :page   ## If we need to define one to one
  has_many :pages


  ## Scopes
  scope :visible, lambda {where({:visible => true})}
  scope :invisible, lambda {where({:visible => false})}
  scope :sorted, lambda {order("subjects.position ASC")}
  scope :newest_first, lambda {order("subjects.created_at DESC")}

  scope :search, lambda {|query|
    where(["name LIKE ?", "%#{query}%"])
  }

  ## Validations
  ## Don't need to validates (in most of cases)
  ##    ids, foreign_keys, timestamps, booleans, counters etc
  ## validates_presence_of vs. validates_length_of
  ##    differnt error messages : "can't be blank" vs. "is too short"
  ##    validates_length_of allows blank as a valid character.

  # validates_presence_of :name
  # validates_length_of   :name, :maximum => 255

  ## Shortcut Validations (a.k.a. Sexy Validations)
  validates :name, :presence => true,
                   :length => {:maximum => 255}


end
