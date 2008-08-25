require File.dirname(__FILE__) + '/../test_helper'
require 'userbrowse_controller'

# Re-raise errors caught by the controller.
class UserbrowseController; def rescue_action(e) raise e end; end

class UserbrowseControllerTest < Test::Unit::TestCase
  def setup
    @controller = UserbrowseController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
