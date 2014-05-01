class User < ActiveRecord::Base
  after_destroy :ensure_an_admin_remains
  validates :name, presence: true, uniqueness: true
  has_secure_password #Validations for presence of password on create, confirmation of password (using a password_confirmation attribute) are automatically added.
  validates_presence_of :password, on: :create
  
  private
  def ensure_an_admin_remains
    if User.count.zero?
      raise "Can't delete last user"
    end
  end
end
