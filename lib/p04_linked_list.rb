include Enumerable

class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    @next.prev = @prev
    @prev.next = @next
  end
end

class LinkedList
  def initialize
    @sentinel = Link.new
    @sentinel.next = @sentinel
    @sentinel.prev = @sentinel
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @sentinel.next
  end

  def last
    @sentinel.prev
  end

  def empty?
    @sentinel.next == @sentinel &&
      @sentinel.prev == @sentinel
  end

  def get(key)
    each { |link| return link.val if link.key == key }
    nil
  end

  def include?(key)
    each { |link| return true if link.key == key }
    false
  end

  def append(key, val)
    tail = @sentinel.prev

    link = Link.new(key, val)

    tail.next = link
    link.next = @sentinel

    @sentinel.prev = link
    link.prev = tail
  end

  def update(key, val)
    each { |link| link.val = val if link.key == key }
  end

  def remove(key)
    link_val = nil
    each do |link|
      if link.key == key
        link_val = link.val
        link.remove
      end
    end

    link_val
  end

  def each
    link = @sentinel.next
    until link == @sentinel
      yield link
      link = link.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
