module OpenFest
  module ApplicationHelper
    def locale_collection
      I18n.available_locales.map do |locale|
        [t("locales.#{locale}"), locale]
      end
    end
  end
end
