require 'test_helper'

class ControllerTest < ActionDispatch::IntegrationTest
  include Capybara::DSL
  include Rails.application.routes.url_helpers
  
  def script
    html = Nokogiri::HTML(@response.body)
    return html.css("script").last.to_s
  end

  test 'each request should clear Landmark tracking' do
    expected = <<-BLOCK.unindent.chomp
      <script>
      landmark.push("initialize", "TEST_KEY");
      landmark.push("trackPage", {});
      landmark.push("track", "Home!", {"foo":1000});
      </script>
    BLOCK

    get root_path
    assert_equal(expected, script)
    get root_path
    assert_equal(expected, script)
  end

  test 'authenticated users should automatically be identified' do
    expected = <<-BLOCK.unindent.chomp
      <script>
      landmark.push("initialize", "TEST_KEY");
      landmark.push("identify", "123", {});
      landmark.push("trackPage", {});
      </script>
    BLOCK

    get "/authenticated"
    assert_equal(expected, script)
  end
end