module KeyValueTree

  class MemoryStore

    def initialize(hash={})
      @hash = hash
    end

    def get(key)
      @hash[key]
    end

    def set(key, value)
      @hash[key] = value
    end

    def del(key)
      @hash.delete(key)
    end

    def to_hash
      @hash
    end

  end

end