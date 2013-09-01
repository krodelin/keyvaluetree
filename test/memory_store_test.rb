require "common"

class MemoryStoreTest < Test::Unit::TestCase

  context "a MemoryStore" do
    setup do
      @store = KeyValueTree::MemoryStore.new()
      @key = "key"
      @nilkey = "nil"
      @value = 42
    end

    should "set a value" do
      assert_equal @value, @store.store(@key, @value)
    end

    should "get a value" do
      @store.store(@key, @value)
      assert_equal(@value, @store.key(@key))
      assert_equal(nil, @store.key(@nilkey))
    end

    should "delete a value" do
      assert_equal nil, @store.key(@key)
      @store.store(@key, @value)
      assert_equal @value, @store.key(@key)
      @store.delete(@key)
      assert_equal nil, @store.key(:@nilkey)
    end

    should "access the hash" do
      assert_nothing_raised(Exception) { @store.to_hash }
      @store.store(@key, @value)
      assert_equal @value, @store.to_hash[@key]
    end

  end
end