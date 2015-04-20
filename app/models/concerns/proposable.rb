module Proposable
  extend ActiveSupport::Concern

  included do
    has_one :proposition, as: :proposable

    Proposition.defined_enums["status"].keys.each do |status|
      scope status.to_sym, -> { joins(:proposition).where(propositions: {status: Proposition.defined_enums["status"][status]}) }
    end
  end
end
