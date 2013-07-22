require 'test_helper'

class ControllerTest < ActionDispatch::IntegrationTest
  include Capybara::DSL
  include Rails.application.routes.url_helpers
  
  def script
    html = Nokogiri::HTML(@response.body)
    return html.css("script").last.to_s
  end

  test 'each_request_should_clear_tracking' do
    expected = <<-BLOCK.unindent.chomp
      <script>
      window.landmark = window.landmark || [];
      landmark.push("track", "Home!", {"foo":1000});
      </script>
    BLOCK

    get root_path
    assert_string(expected, script)
    get root_path
    assert_string(expected, script)
  end

  test 'authenticated_users_should_automatically_be_identified' do
    expected = <<-BLOCK.unindent.chomp
      <script>
      window.landmark = window.landmark || [];
      landmark.push("identify", "123", {});
      </script>
    BLOCK

    get "/authenticated"
    assert_string(expected, script)
  end
end