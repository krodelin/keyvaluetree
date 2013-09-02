module KeyValueTree

  # Hash implements an hierachical Hash (i.e. Hashes in Hashes) backed by a flat-hash Store.
  class Hash

    attr_reader :store

    def initialize(store = KeyValueTree::MemoryStore.new(), key=nil, parent = nil)
      @key = key.to_s
      @parent = parent
      @store = store
    end

    # @!group Operations

    # Return the value for the given key. If the the key is nil return self. If the value is nil (empty) return a new instance of Hash for the key
    # @param [String]key The key to fetch
    # @return [String,KeyValueTree::Hash] The result
    def [] (key)
      return self if key.nil?
      value = @store.key(key_path_string(key))
      return value unless value.nil?
      return KeyValueTree::Hash.new(@store, key, self)
    end

    # Set a value for the given key.
    # @param [String]key The key to set
    # @param [String]value The value to set
    # @return [String] The value
    def []= (key, value)
      if value.is_a?(::Hash)
        value.each do |hash_key, hash_value|
          self[key][hash_key] = hash_value
        end
        return
      end
      #if value.is_a?(Array)
      #  value.each_with_index do |value, index|
      #    self[key][index] = value
      #  end
      #  return
      #end
      @store.store(key_path_string(key), value)
      return value
    end

    # Return the value for the given key. If the the key is nil return self. If the value is nil (empty) return a new instance of Hash for the key
    # @param [String]key The key to fetch
    # @return [String,KeyValueTree::Hash] The result
    def [] (key)
      return self if key.nil?
      value = @store.key(key_path_string(key))
      return value unless value.nil?
      return KeyValueTree::Hash.new(@store, key, self)
    end

    # Delete the value for the given key
    # @param [String]key The key to delete
    # @return [String,KeyValueTree::Hash] The value of the deleted key
    def delete(key)
      @store.delete(key_path_string(key.to_s))
    end

    # Delete the value for the given key and it's sub-keys
    # @note This method might raise an exception if the store does not support the operation.
    # @param [String]key The key to delete
    # @return [nil] Undefined
    def delete_all(key)
      @store.delete_all(key_path_string(key.to_s))
    end

    # Import the given ::Hash into the Hash.
    # @param [Hash]object The object to import
    # @return [self]
    def import(object)
      self[nil] = object
    end

    # Return all keys.
    # @note This method might raise an exception if the store does not support the operation.
    # @return [Array<String>] An Array of keys
    def keys
      @store.keys_starting_with(key_path_string()).map { |each| each.split(".").first }.uniq
    end

    # Return true if the Hash is the root Hash (i.e. has no parent)
    # @return [Boolean]
    def root?
      @parent.nil?
    end

    # @!endgroup

    # @!group Helpers

    # Handle method dispatch for missing methods. Provides the functionality to access a value using hash.key or set it via hash.key = value.
    # @param [Symbol]method The called method
    # @param [Array]args Provided arguments (if any)
    def method_missing(method, *args)
      property = method.to_s
      if property =~ /=$/
        return self[property.chop] = args[0]
      else
        return self[property]
      end
    end

    # Return the keypath to self as Array of keys. Append key is given
    # @param [String,nil]key The subkey (if any)
    # @return [Array<String>] An array of keys (starting with the root key)
    def key_path(key = nil)
      if root?
        return [] if key.nil?
        return [key.to_s]
      else
        return (@parent.key_path + [@key]).compact if key.nil?
        return (@parent.key_path + [@key, key.to_s]).compact
      end
    end

    # Return the keypath to self as dot separated String of keys. Append key is given
    # @param [String,nil]key The subkey (if any)
    # @return [String] A dot separated String of keys (starting with the root key)
    def key_path_string(key = nil)
      result = ''
      key_path(key).each_with_index do |value, index|
        # if value.is_a?(Integer)
        #  result = result + "[#{value}]"
        # else
        result = result + '.' unless index == 0
        result = result + value
        # end
      end
      return result
    end

    # @!endgroup

  end

end