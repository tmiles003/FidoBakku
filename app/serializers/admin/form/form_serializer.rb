class Admin::Form::FormSerializer < ActiveModel::Serializer
  
  attributes :id, :name, :shared, :form_part, :shared_forms, :teams, :form_users
  
  has_many :children, serializer: ::Admin::Form::SharedFormSerializer
  has_many :form_sections, serializer: ::Admin::Form::SectionSerializer
  
  # null != false...
  def shared
    !!object.shared
  end
  
  def form_part
    ::FormPart.find_or_create_by(form_id: object.id)
  end
  
  # the possible shared forms to use as "parent"
  def shared_forms
    shared_forms = ::Form.in_account(scope.account.id).where(shared: 1).where.not(id: object.id)
    ActiveModel::ArraySerializer.new(shared_forms, each_serializer: ::Admin::Form::SharedFormSerializer)
  end
  
  def teams
    teams = scope.account.teams
    ActiveModel::ArraySerializer.new(teams, each_serializer: ::Admin::TeamSerializer)
  end
  
  def form_users
    form_users = ::FormUser.in_account(scope.account.id)
      .where('form_users.form_id IS NULL OR form_users.form_id = ?', object.id)
      .includes(:form, user: :team)
    ActiveModel::ArraySerializer.new(form_users, each_serializer: ::Admin::Form::FormUserSerializer)
  end
  
end
