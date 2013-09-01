require "common"

class HashTest < Test::Unit::TestCase

  context "Hash" do

    setup do
      @hash_object ={:a => :b}
      @array_object = [:a, :b]
      @store = KeyValueTree::MemoryStore.new()
      @root = KeyValueTree::Hash.new(@store)
      @key1 = 'key1'
      @value1 = 'value1'
      @key2 = 'key2'
      @value2 = 'key2'
    end

    should "create w/o arguments" do
      root = nil
      assert_nothing_raised(Exception) { root = KeyValueTree::Hash.new(@store) }
      assert_instance_of(KeyValueTree::Hash, root)
    end

    should "create with store" do
      root = nil
      assert_nothing_raised(Exception) { root = KeyValueTree::Hash.new(@store) }
      assert_instance_of(KeyValueTree::Hash, root)
    end

    should "allow setting keys" do
      assert_nothing_raised (Exception) { @root[@key1] = @value1 }
      assert_nothing_raised (Exception) { @root.key2 = @value2 }
    end

    should "allow getting values" do
      @root[@key1] = @value1
      @root.key2 = @value2
      assert_equal @value1, @root[@key1]
      assert_equal @value2, @root.key2
    end

    should "return empty keypath for root" do
      assert_equal [], @root.key_path()
    end

    should "know if it it's root" do
      assert @root.root?
      assert !@root.key.root?
    end

    should "create correct keypaths" do
      assert_equal ['key1', 'key2', 'key3', 'key4'], @root.key1.key2.key3.key4.key_path()
      assert_equal "key1.key2.key3.key4", @root.key1.key2.key3.key4.key_path_string()
      @root.key1.key2.key3.key4 = @value1
      assert_equal 1, @store.keys.size
      assert_equal 'key1.key2.key3.key4', @store.keys.first
    end

    should "delete subkey when being deleted" do
      @root.one.a.A = 'A'
      @root.one.a.B = 'B'
      @root.two.b.A = 'AA'
      @root.two.b.B = 'BB'
      assert_equal 4, @store.keys.size

      @root.one.a.delete(:A)
      assert_equal 3, @store.keys.size

      @root.delete(:two)
      assert_equal 1, @store.keys.size
    end

    should "return keys" do
      @root.one.a.A = 'A'
      @root.one.a.B = 'B'
      @root.two.b.A = 'AA'
      @root.two.b.B = 'BB'
      assert_same_elements ["one", "two"], @root.keys
    end

  end

end