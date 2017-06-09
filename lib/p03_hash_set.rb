require_relative 'p02_hashing'

class HashSet
  attr_reader :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    unless include?(key)
      resize! if @count + 1 > num_buckets
      self[key.hash] << key
      @count += 1
    end
  end

  def include?(key)
    self[key.hash].include?(key)
  end

  def remove(key)
    self[key.hash].delete(key)
    @count -= 1
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @store = Array.new(num_buckets * 2) { Array.new }
    old_store.each do |bucket|
      bucket.each do |el|
        self[el.hash] << el
      end
    end
  end
end
