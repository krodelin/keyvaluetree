require "common"

class MemoryStoreTest < Test::Unit::TestCase

  context "a MemoryStore" do
    setup do
      @store = KeyValueTree::MemoryStore.new()
      @key = :key
      @nilkey = :nonexistent
      @value = 42
    end

    should "set a value" do
      assert_equal @value, @store.set(@key, @value)
    end

    should "get a value" do
      @store.set(@key, @value)
      assert_equal(@value, @store.get(@key))
      assert_equal(nil, @store.get(:@nilkey))
    end

    should "delete a value" do
      assert_equal nil, @store.get(@key)
      @store.set(@key, @value)
      assert_equal @value, @store.get(@key)
      @store.del(@key)
      assert_equal nil, @store.get(:@nilkey)
    end

    should "access the hash" do
      assert_nothing_raised(Exception) { @store.to_hash }
      @store.set(@key, @value)
      assert_equal @value, @store.to_hash[@key]
    end

  end
end