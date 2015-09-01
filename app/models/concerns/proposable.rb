module Proposable
  extend ActiveSupport::Concern

  included do
    has_one :proposition, as: :proposable, dependent: :destroy
    has_one :proposer, through: :proposition
    delegate :email, to: :proposer, prefix: true

    Proposition.defined_enums["status"].keys.each do |status|
      scope status.to_sym, -> { joins(:proposition).where(propositions: {status: Proposition.defined_enums["status"][status]}) }
    end
  end

  def proposable_type
    self.class.model_name.human
  end

  def notification_email
    conference.email
  end

  def proposable_title
    title
  end

  def proposable_description
  end
end
