class Goal < ActiveRecord::Base
  
  belongs_to :user
  
  validates :title, length: {
    in: 2..100,
    too_short: 'Too short',
    too_long: 'Too long'
  }
  
  # validate user_id is you or someone in the admin/manager's team
  
  scope :for_user, lambda { |user, param|
    user_id = param.nil? ? user.id : param.to_i
    where(user_id: user_id)
  }
  
  scope :with_limit, lambda { |limit|
    limit(limit) unless limit.nil?
  }
  
  # return array of goals, 1 per user in team, other than current user
  def self.team_goals user
    # SELECT * FROM
    # ( select * from goals where is_private = 0 and due_date >= '2014-04-02' 
    #   and user_id != 7 and user_id in (select user_id from team_users where team_id = 1) order by due_date asc ) as goals_tmp
    # group by user_id
    
    # no team goals if user is not in a team
    return [] if user.team.nil?
    
    # get team user ids
    user_ids = ::TeamUser.select(:user_id)
      .where(team_id: user.team.id)
      .where('user_id != ?', user.id)
      .pluck(:user_id)
      
    # get sql for tmp table
    goals_tmp = ::Goal.where(is_private: false) # only visible goals
      .where('due_date >= ?', Date.today - 1) # due for yesterday, or later
      .where(user_id: user_ids)
      .order(due_date: :asc)
    # logger.info goals_tmp.to_sql
    
    # return goals
    goals = ::Goal.select('goals_tmp.*')
      .from(goals_tmp, :goals_tmp)
      .group('goals_tmp.user_id')
      .reorder('')
      .limit(30)
    # logger.info goals.to_sql
    # logger.info goals.to_yaml
    
  end
  
  def to_param
    [id, self.slug].join('/')
  end
  
  def slug
    self.title.downcase.gsub(/[^a-z0-9]/, '-').squeeze('-')
  end
  
end
