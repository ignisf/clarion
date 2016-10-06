class Proposition < ActiveRecord::Base
  belongs_to :proposer, class_name: 'User'
  belongs_to :proposable, polymorphic: true, dependent: :destroy
  enum status: [:undecided, :approved, :rejected, :backup]
  delegate :proposable_title, :proposable_type, :proposable_description, to: :proposable

  after_create :send_creation_notification
  before_destroy :send_withdrawal_notification

  def confirm!
    update(confirmed_at: Time.now)
  end

  def send_creation_notification
    PropositionMailer.new_proposition_notification(self).deliver_later
  end

  def send_withdrawal_notification
    PropositionMailer.proposition_withdrawal_notification(self).deliver_later
  end
end
