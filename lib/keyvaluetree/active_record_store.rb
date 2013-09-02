module KeyValueTree

  class ActiveRecordStore < Store

    def initialize(storage_class, key_symbol = :key, value_symbol = :value)
      @storage_class = storage_class
      @key_symbol = key_symbol
      @value_symbol = value_symbol
    end

    def key(key)
      entry = @storage_class.find(@key_symbol => key)
      entry ? entry[@value_symbol] : nil
    end

    def store(key, value)
      setting = @storage_class.find_or_create(@key_symbol => key)
      setting[@value_symbol] = value
      setting.save!
    end

    def delete(key)
      @storage_class.delete_all(:key => key)
    end

    def keys
      @storage_class.all.map { |each| each[@key_symbol] }
    end

    def keys_starting_with(key)
      self.keys.select do |sub_key|
        sub_key.start_with?(key.to_s)
      end
    end

    def delete_all(key)
      keys_starting_with(key.to_s).each do |each|
        self.delete(each)
      end
    end

  end

end