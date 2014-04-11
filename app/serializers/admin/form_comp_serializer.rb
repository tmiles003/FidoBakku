class Admin::FormCompSerializer < ActiveModel::Serializer
  attributes :id, :form_section_id, :content, :ordr
end
