module KeyValueTree

  class Hash

    attr_reader :store

    def initialize(store = KeyValueTree::MemoryStore.new(), key=nil, parent = nil)
      @key = key.to_s
      @parent = parent
      @store = store
    end

    def [] (key)
      return self if key.nil?
      value = @store.key(key_path_string(key))
      return value unless value.nil?
      return KeyValueTree::Hash.new(@store, key, self)
    end

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

    def keys
      @store.keys_starting_with(key_path_string()).map { |each| each.split(".").first }.uniq
    end

    def import(object)
      self[nil] = object
    end
  end

end