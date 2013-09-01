module KeyValueTree

  class Store

    def delete(key)
      self.delete_keys_start_with(key.to_s)
    end

    def delete_keys_start_with(key)
      keys_start_with(key.to_s).each do |each|
        self.basic_delete(each)
      end
    end

    def keys_start_with(key)
      self.keys.select do |sub_key|
        sub_key.start_with?(key.to_s)
      end
    end

  end

end