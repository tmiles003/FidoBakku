class Team < ActiveRecord::Base
  
  belongs_to :account
  
  has_many :team_users, dependent: :destroy
  has_many :users, through: :team_users
  
  validates :name, length: {
    in: 1..100,
    too_short: 'Too short',
    too_long: 'Too long'
  }
  
  def as_json(options)
    h = super({ except: [:account_id] }.merge(options || {}))
  end
  
end
