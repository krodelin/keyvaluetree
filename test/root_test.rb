require "common"

class RootTest < Test::Unit::TestCase

  context "KeyValueTree" do

    setup do
      @hash_object ={:a => :b}
      @array_object = [:a, :b]
      @store = KeyValueTree::MemoryStore.new()
    end

    should "be created from an object" do
      assert_nothing_raised(Exception) { KeyValueTree.from(@hash_object) }
    end

    should "be created from an object with store" do
      assert_nothing_raised(Exception) { KeyValueTree.from(@hash_object, @store) }
    end


  end

end