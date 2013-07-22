require 'test_helper'

class LandmarkTest < ActiveSupport::TestCase
  setup do
    Landmark::Rails.clear()
  end

  test "Prologue should load JavaScript" do
    expected = <<-BLOCK.unindent
      <script src="https://landmark.io/landmark.js" data-api-key="TEST_KEY"></script>
    BLOCK
    assert_string(expected, Landmark::Rails.javascript_include_tag)
  end

  test "Identification should not be in JavaScript output no invocations were made" do
    assert_string("", Landmark::Rails.javascript_invocation_script)
  end

  test "Identify should add identification to the JavaScript output" do
    Landmark::Rails.identify(123)
    expected = <<-BLOCK.unindent
      landmark.push("identify", \"123\", {});
    BLOCK
    assert_string(expected, Landmark::Rails.javascript_invocation_script)
  end

  test "Track should add tracking to the JavaScript output" do
    Landmark::Rails.track("/index.html", {:foo => 1, :bar => "baz"})
    Landmark::Rails.track("Sign Up")
    Landmark::Rails.track_page_view({:foo => 2})
    expected = <<-BLOCK.unindent
      landmark.push("track", "/index.html", {"foo":1,"bar":"baz"});
      landmark.push("track", "Sign Up", {});
      landmark.push("trackPageView", {"foo":2});
    BLOCK
    assert_string(expected, Landmark::Rails.javascript_invocation_script)
  end

  test "javascript output should contain everything" do
    Landmark::Rails.identify(123)
    Landmark::Rails.track("/index.html")
    expected = <<-BLOCK.unindent
      <script src="https://landmark.io/landmark.js" data-api-key="TEST_KEY"></script>
      <script>
      window.landmark = window.landmark || [];
      landmark.push("identify", "123", {});
      landmark.push("track", "/index.html", {});
      </script>
    BLOCK
    assert_string(expected, Landmark::Rails.javascript_tag)
  end
end
