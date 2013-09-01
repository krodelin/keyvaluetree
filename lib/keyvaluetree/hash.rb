module KeyValueTree

  class Hash

    def initialize(key=nil, parent = nil, store = KeyValueTree::MemortyStore.new())
      @key = key.to_s
      @parent = parent
      @store = store
    end

    def [] (key)
      value = @store.key(key_path_string(key))
      return value unless value.nil?
      return KeyValueTree::Hash.new(key, self, @store)
    end

    def []= (key, value)
      if value.is_a?(Hash)
        value.each do |hash_key, hash_value|
          self[key_path_string(key)][hash_key] = hash_value
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

    def method_missing(method, *args)
      property = method.to_s
      if property =~ /=$/
        return self[property.chop] = args[0]
      else
        return self[property]
      end
    end

    def key_path(key = nil)
      if root?
        return [] if key.nil?
        return [key.to_s]
      else
        return (@parent.key_path + [@key]).compact if key.nil?
        return (@parent.key_path + [@key, key.to_s]).compact
      end
    end

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

    def root?
      @parent.nil?
    end

    def delete(key)
      @store.delete(key_path_string(key.to_s))
    end

  end

end