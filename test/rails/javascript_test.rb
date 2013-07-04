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

  test "Identification should not be in JavaScript output if Identify() was not called" do
    assert_equal("", Landmark::Rails.javascript_identify_script)
  end

  test "Identify should add identification to the JavaScript output" do
    Landmark::Rails.identify(123)
    expected = <<-BLOCK.unindent
      landmark.push("identify", \"123\", {});
    BLOCK
    assert_equal(expected, Landmark::Rails.javascript_identify_script)
  end

  test "Tracking should not be in JavaScript output if Track() was not called" do
    assert_equal("", Landmark::Rails.javascript_track_script)
  end

  test "Track should add tracking to the JavaScript output" do
    Landmark::Rails.track("/index.html", {:foo => 1, :bar => "baz"})
    Landmark::Rails.track("Sign Up")
    expected = <<-BLOCK.unindent
      landmark.push("track", "/index.html", {"foo":1,"bar":"baz"});
      landmark.push("track", "Sign Up", {});
    BLOCK
    assert_equal(expected, Landmark::Rails.javascript_track_script)
  end

  test "javascript output should contain everything" do
    Landmark::Rails.identify(123)
    Landmark::Rails.track("/index.html")
    expected = <<-BLOCK.unindent
      <script>window.landmark=[];</script>
      <script src="https://landmark.io/landmark.js"></script>
      <script>
      landmark.push("identify", \"123\", {});
      landmark.push("track", "/index.html", {});
      </script>
    BLOCK
    assert_equal(expected, Landmark::Rails.javascript_tag)
  end
end
