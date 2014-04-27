class Admin::Form::CompSerializer < ActiveModel::Serializer
  
  attributes :id, :content, :ordr, :in_use
  
  def in_use
    !!object.in_use
  end
  
end
