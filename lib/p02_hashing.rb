class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    sum = 0
    each_with_index do |el, idx|
      sum = sum ^ el.hash * (idx + 1)
    end

    sum
  end
end

class String
  def hash
    bytes.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    sort.hash
  end
end
