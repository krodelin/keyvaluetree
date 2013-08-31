require "test/unit"
require "shoulda-context"
require 'minitest/reporters'
MiniTest::Reporters.use!

require "keyvaluetree"

class MemoryStoreTest < Test::Unit::TestCase

  context "a MemoryStore" do
    setup do
      @store = KeyValueTree::MemoryStore.new()
    end

    should "set a value" do
      key = :key
      value = 42
      assert_equal value, @store.set(key, value)
    end

    should "get a value" do
      key = :key
      value = 42
      @store.set(key, value)
      assert_equal value, @store.get(key)
      assert_equal nil, @store.get(:nonexistent)
    end

    should "delete a value" do
      key= :key
      assert_equal nil, @store.get(key)
      value = 42
      @store.set(key, value)
      assert_equal value, @store.get(key)
      @store.del(key)
      assert_equal nil, @store.get(:nonexistent)
    end

  end
end