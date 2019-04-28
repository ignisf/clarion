class CallForParticipation < ActiveRecord::Base
  belongs_to :conference

  def open!
    self.opens_at = Time.now unless opens_at.present?
    self.closes_at = nil
    save
  end

  def close!
    self.closes_at = Time.now
    save
  end

  def open?
    opens_at.present? && (opens_at < Time.now)
  end

  def closed?
    closes_at.present? && (closes_at < Time.now)
  end

  def in_progress?
    open? && !closed?
  end
end
