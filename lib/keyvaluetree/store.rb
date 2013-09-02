module KeyValueTree

  # This class defines the methods expected by KeyValueTree::Hash for it's Store backend
  class Store

    # @!group Required methods

    # Return the value for the given key
    # @param [String]key The key to fetch
    # @return [String] The value for key or nil
    def key(key)
      raise NotImplementedError
    end

    # Store the value at the given key
    # @param [String]key The key to store
    # @param [String]value The value to store
    # @return [String] The value
    def store(key, value)
      raise NotImplementedError
    end

    # Delete the given key
    # @param [String]key The key to delete
    # @return [String] The value for key or nil
    def delete(key)
      raise NotImplementedError
    end

    # @!endgroup

    # @!group Optional methods (as some stores don't support (sub-) key enumeration)

    # Fetch all keys in store
    # @return [Array<String>] All keys in store
    def keys
      raise NotImplementedError
    end

    # Fetch all keys in store with the given key prefix
    # @param [String]key The key prefix
    # @return [Array<String>] All keys in store
    def keys_starting_with(key)
      self.keys.select do |sub_key|
        sub_key.start_with?(key.to_s)
      end
    end

    # Delete all keys starting with the given prefix
    # @param [String]key The key prefix
    # @return nil
    def delete_all(key)
      keys_starting_with(key.to_s).each do |each|
        self.delete(each)
      end
    end

    # Convert the store to a *hierachical* Hash
    # return [Hash]
    def to_hash
      raise NotImplementedError
    end

    # @!endgroup

  end

end