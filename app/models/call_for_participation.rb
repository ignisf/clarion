class CallForParticipation < ActiveRecord::Base
  belongs_to :conference

  def open!
    self.opens_at = Time.now unless self.opens_at.present?
    self.closes_at = nil
    save
  end

  def close!
    self.closes_at = Time.now
    save
  end

  def open?
    self.opens_at.present? and self.opens_at < Time.now
  end

  def closed?
    self.closes_at.present? and self.closes_at < Time.now
  end

  def in_progress?
    open? and not closed?
  end
end
