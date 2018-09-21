require 'test_helper'

class PostTest < ActiveSupport::TestCase
  setup do
    @post = posts(:one)
  end

  test "should return empty array when tag redis is down while listing tags" do
    @post.add_tag "gremlins"
  
    Toxiproxy[/redis/].down do
      assert_equal [], @post.tags
    end
  end
end
