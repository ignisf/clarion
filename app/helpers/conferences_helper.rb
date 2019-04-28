module ConferencesHelper
  def submissions_chart_data(conference)
    submissions_by_day = conference.submissions_grouped_by_day
    confirmed_by_day = conference.submissions_grouped_by_confirmation_day
    start_date = conference.created_at.to_date
    end_date = Time.zone.now.to_date < conference.start_date.to_date ? Time.zone.now.to_date : conference.start_date.to_date

    chart_data = (start_date..end_date).map { |date|
      {
        created_at: date,
        new_submissions: submissions_by_day[date].try(:first).try(:number) || 0,
        new_confirmations: confirmed_by_day[date].try(:first).try(:number) || 0,
      }
    }

    chart_data.each_with_index do |entry, index|
      entry[:all_submissions] = if index == 0
        entry[:new_submissions]
      else
        chart_data[index - 1][:all_submissions] + entry[:new_submissions]
      end

      entry[:all_confirmations] = if index == 0
        entry[:new_confirmations]
      else
        chart_data[index - 1][:all_confirmations] + entry[:new_confirmations]
      end
    end
    chart_data
  end
end
