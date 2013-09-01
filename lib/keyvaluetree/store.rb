module KeyValueTree

  class Store

    def initialize(hash={})
      raise NotImplementedError
    end

    def key(key)
      raise NotImplementedError
    end

    def store(key, value)
      raise NotImplementedError
    end

    def basic_delete(key)
      raise NotImplementedError
    end

    def keys
      raise NotImplementedError
    end

    def to_hash
      raise NotImplementedError
    end

    def delete(key)
      self.delete_keys_start_with(key.to_s)
    end

    def delete_keys_start_with(key)
      keys_starting_with(key.to_s).each do |each|
        self.basic_delete(each)
      end
    end

    def keys_starting_with(key)
      self.keys.select do |sub_key|
        sub_key.start_with?(key.to_s)
      end
    end

  end

end