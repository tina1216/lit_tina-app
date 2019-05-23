require 'bundler/setup'
Bundler.require

# ActiveRecord::Base.establish_connection(ENV['DATABASE_URL']||"sqlite3:db/development.db")
ActiveRecord::Base.establish_connection(ENV['DATABASE_URL']||"sqlite3:db/development.db")

class User < ActiveRecord::Base
  has_secure_password
  validates :mail,
    presence: true,
    format: {with:/.+@.+/}
  validates :password,
  length: {in: 3..15}

  has_many :contributions
  has_many :goods
end

class Contribution < ActiveRecord::Base
  belongs_to :user

  has_many :goods
end

class Good < ActiveRecord::Base
  belongs_to :contribution
  belongs_to :user
end
