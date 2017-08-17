class AdminUser < ActiveRecord::Base
  ## We changed class name from User to AdminUser;; corresponding table name = admin_users
  ## The other option would have been to add configuration like below
  ## self.table_name = "admin_users"

  has_secure_password

  has_and_belongs_to_many :pages, :join_table => "admin_users_pages"
  
  has_many :section_edits
  has_many :sections, :through => :section_edits

  # ## Validations
  EMAIL_REGEX=/\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i

  # validates_presence_of :first_name
  # validates_length_of    :first_name, :maximum => 25

  # validates_presence_of :last_name
  # validates_length_of    :last_name, :maximum => 50

  # validates_presence_of :username
  # validates_length_of    :username, :within => 8..25
  # validates_uniqueness_of :username

  # validates_presence_of :email
  # validates_length_of    :email, :maximum => 100
  # validates_uniqueness_of :email
  # validates_format_of    :email, :with => EMAIL_REGEX
  # validates_confirmation_of :email

  ## Shortcut Validations (a.k.a. Sexy Validations)
  validates :first_name, :presence => true,
                         :length => {:maximum => 25}

  validates :last_name, :presence => true,
                         :length => {:maximum => 50}

  validates :username, :presence => true,
                       :length => {:within => 8..25},
                       :uniqueness => true
  validates :email, :presence => true,
                    :length => {:maximum => 100},
                    :uniqueness => true,
                    :format => {:with => EMAIL_REGEX},
                    :confirmation => true

  ## Demonstration of custom validation
  FORBIDDEN_USERNAMES = ['littlebopeep', 'humptydumpty']
  validate :username_is_allowed
  validate :no_new_users_on_saturday, :on => :create

  def username_is_allowed
    if FORBIDDEN_USERNAMES.include?(username)
      errors.add(:username, "has been restricted from use")
    end
  end

  ## Errors not specific to any attributes can be added to
  ## errors[:base]
  def no_new_users_on_saturday
    if Time.now.saturday? 
      errors[:base] << "No new users on Saturdays."
    end
  end
end























