class CreateSlugsForExistingConferences < ActiveRecord::Migration
  class Conference < ActiveRecord::Base
  end

  def change
    Globalize.with_locale(:en) do
      Conference.find_each do |c|
        c.slug = c.title.gsub(/\s+/, '-')
        c.save!
      end
    end
  end
end
