class User < ActiveRecord::Base
  acts_as_authentic

  enum_attr :gender, %w(male female)

end
