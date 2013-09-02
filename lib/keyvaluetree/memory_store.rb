module KeyValueTree

  class MemoryStore < Store

    def initialize(hash={})
      @hash = hash
    end

    def key(key)
      @hash[key.to_s]
    end

    def store(key, value)
      @hash[key.to_s] = value
    end

    def delete(key)
      @hash.delete(key.to_s)
    end

    def keys
      @hash.keys
    end

    def to_hash
      @hash
    end

  end

end