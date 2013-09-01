module KeyValueTree

  class TransactionStore < Store

    def initialize(store = MemoryStore.new())
      @store = store
      @access_mutex = Mutex.new()
      reset()
    end

    def key(key)
      @access_mutex.synchronize do
        result = @changed_properties[key]
        return result unless result.nil?
        @store.key(key)
      end
    end

    def store(key, value)
      @access_mutex.synchronize do
        @changed_properties[key] = value
        @deleted_property_keys.delete(key)
        value
      end
    end

    def basic_delete(key)
      @access_mutex.synchronize do
        @changed_properties.delete(key)
        @deleted_property_keys << key
      end
    end

    def keys
      @access_mutex.synchronize do
        result = @store.keys + @changed_properties.keys
        @deleted_property_keys.each do |key|
          result.delete(key)
        end
        result
      end
    end

    def to_hash
      result = @store.to_hash
      @changed_properties.each do |key, value|
        result[key] = value
      end
      @deleted_property_keys.each do |key|
        result.delete(key)
      end
      result
    end

    def commit
      @access_mutex.synchronize do
        @changed_properties.each do |key, value|
          @store.store(key, value)
        end
        @deleted_property_keys.each do |key|
          @store.delete(key)
        end
        reset()
      end
    end

    def rollback
      @access_mutex.synchronize do
        reset()
      end
    end

    def pending_changes?
      !(@changed_properties.empty? && @deleted_property_keys.empty?)
    end

    private

    def reset
      @changed_properties = {}
      @deleted_property_keys = []
    end

  end
end