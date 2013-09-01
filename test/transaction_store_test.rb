require "common"

class TransactionStoreTest < MemoryStoreTest

  context "a TransactionStore" do
    setup do

      @embedded_store = KeyValueTree::MemoryStore.new()
      @store = KeyValueTree::TransactionStore.new(@embedded_store)
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
      assert_equal(nil, @store.key(:@nilkey))
    end

    should "delete a value" do
      assert_equal nil, @store.key(@key)
      @store.store(@key, @value)
      assert_equal @value, @store.key(@key)
      @store.delete(@key)
      assert_equal nil, @store.key(@nilkey)
    end

    should "access the hash" do
      assert_nothing_raised(Exception) { @store.to_hash }
      @store.store(@key, @value)
      assert_equal @value, @store.to_hash[@key]
    end

    should "set a value with commit" do
      assert_equal @value, @store.store(@key, @value)
      assert_equal 1, @store.keys.size
      assert_equal 0, @embedded_store.keys.size
      @store.commit
      assert_equal 1, @store.keys.size
      assert_equal 1, @embedded_store.keys.size
    end

    should "set a value with rollback" do
      assert_equal @value, @store.store(@key, @value)
      assert_equal 1, @store.keys.size
      assert_equal 0, @embedded_store.keys.size
      @store.rollback
      assert_equal 0, @store.keys.size
      assert_equal 0, @embedded_store.keys.size
    end

    should "track changes" do
      assert !@store.pending_changes?
      @store.store(@key, @value)
      assert @store.pending_changes?
      @store.commit
      assert !@store.pending_changes?
      @store.delete(@key)
      assert @store.pending_changes?
      @store.commit
      assert !@store.pending_changes?
    end

  end
end
