class User < ActiveRecord::Base
  acts_as_authentic do |config|
    config.validate_email_field = false
    config.validate_password_field = false
  end

  #validates_length_of :email, :within => 6..100, :unless => self.email.blank?
  #validates_format_of :email, :with => Authlogic::Regex.email, :unless => self.email.blank?
  #validates_uniqueness_of :email, :unless => self.email.blank?
  #validates_length_of :password, :minimum => 4, :unless => self.email.blank?
  #validates_confirmation_of :password, :if => :validate_password?

  has_many :devices

  #before_create :update_attributes

  private
  def update_attributes
    self.password_confirmation = self.password
  end

end
