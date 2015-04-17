module PropositionAccepting
  extend ActiveSupport::Concern

  included do
    has_many :propositions, as: :proposition_accepting
  end
end
