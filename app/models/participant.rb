class Participant < ActiveRecord::Base
  self.table_name = :participants
  self.primary_key = :participant_id

  def twitter=(handle)
    write_attribute :twitter, handle.gsub(/\A@/,'') if handle
  end

  def name
    "#{first_name} #{last_name}"
  end

  def has_personal_profile?
    user_id.present?
  end
end
