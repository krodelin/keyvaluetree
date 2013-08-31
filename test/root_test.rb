require "common"

class RootTest < Test::Unit::TestCase

  context "KeyValueTree" do

    setup do
      @hash_object ={:a => :b}
      @array_object = [:a, :b]
      @store = KeyValueTree::MemoryStore.new()
    end

    should "be created from an object" do
      root = nil
      assert_nothing_raised(Exception) { root = KeyValueTree.from(@hash_object) }
      assert_instance_of(KeyValueTree::Root, root)
    end

    should "be created from an object with store" do
      root = nil
      assert_nothing_raised(Exception) { root = KeyValueTree.from(@hash_object, @store) }
      assert_instance_of(KeyValueTree::Root, root)
    end


  end

end