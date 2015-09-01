# coding: utf-8
class PropositionMailer < ActionMailer::Base
  def new_proposition_notification(proposition)
    @proposition = proposition
    mail(to: proposition.proposable.conference.email, subject: "Ново предложение за #{@proposition.proposable_type}: #{@proposition.proposable_title}")
  end

  def proposition_withdrawal_notification(proposition)
    @proposition = proposition
    mail(to: proposition.proposable.conference.email, subject: "Оттеглено е предложение за #{@proposition.proposable_type}: #{@proposition.proposable_title}")
  end
end
