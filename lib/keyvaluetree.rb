require "keyvaluetree/version"

require 'keyvaluetree/memory_store'

require 'keyvaluetree/root'

module KeyValueTree

  def self.from(object, store=MemoryStore.new())
    KeyValueTree::Root.from(object, store)
  end

end
