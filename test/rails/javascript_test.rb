require 'test_helper'

class LandmarkTest < ActiveSupport::TestCase
  setup do
    Landmark::Rails.clear()
  end

  test "Prologue should load JavaScript" do
    expected = <<-BLOCK.unindent
      <script>window.landmark=[];</script>
      <script src="https://landmark.io/landmark.js"></script>
    BLOCK
    assert_equal(expected, Landmark::Rails.javascript_prologue_tag)
  end

  test "Initialization should set the appropriate API key from the config file" do
    assert_equal("landmark.push(\"initialize\", \"TEST_KEY\");\n", Landmark::Rails.javascript_initialize_script)
  end

  test "Identification should not be in JavaScript output no invocations were made" do
    assert_equal("", Landmark::Rails.javascript_invocation_script)
  end

  test "Identify should add identification to the JavaScript output" do
    Landmark::Rails.identify(123)
    expected = <<-BLOCK.unindent
      landmark.push("identify", \"123\", {});
    BLOCK
    assert_equal(expected, Landmark::Rails.javascript_invocation_script)
  end

  test "Track should add tracking to the JavaScript output" do
    Landmark::Rails.track("/index.html", {:foo => 1, :bar => "baz"})
    Landmark::Rails.track("Sign Up")
    Landmark::Rails.track_page({:foo => 2})
    expected = <<-BLOCK.unindent
      landmark.push("track", "/index.html", {"foo":1,"bar":"baz"});
      landmark.push("track", "Sign Up", {});
      landmark.push("trackPage", {"foo":2});
    BLOCK
    assert_equal(expected, Landmark::Rails.javascript_invocation_script)
  end

  test "javascript output should contain everything" do
    Landmark::Rails.identify(123)
    Landmark::Rails.track("/index.html")
    expected = <<-BLOCK.unindent
      <script>window.landmark=[];</script>
      <script src="https://landmark.io/landmark.js"></script>
      <script>
      landmark.push("initialize", "TEST_KEY");
      landmark.push("identify", "123", {});
      landmark.push("track", "/index.html", {});
      </script>
    BLOCK
    assert_equal(expected, Landmark::Rails.javascript_tag)
  end
end
