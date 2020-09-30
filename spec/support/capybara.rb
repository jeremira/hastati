# frozen_string_literal: true

RSpec.configure do |config|
  config.before type: :system do
    driven_by(:rack_test)
    #driven_by(:selenium_chrome)
  end
  config.before type: :system, js: true do
    driven_by(:selenium_chrome_headless)
    # driven_by(:selenium_chrome)
  end
end
