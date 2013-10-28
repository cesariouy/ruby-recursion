# takes a start and an end and returns an array of all numbers between
def range(starter, ender)
  result = []
  result << starter+1

  if starter != ender-2
    result.concat(range(starter+1, ender).flatten)
  else
    [ender-1]
  end
end

# a recursive way of taking the sum of an array
def recursive_sum(array)
  if array.size > 1
    array[0] + recursive_sum(array[1..-1])
  else
    array[0]
  end
end

# an iterative way of taking the sum of an array
def iterative_sum(array)
  array.inject{|sum,addend| sum + addend}
end

# returns the result of raising a base to an exponent
def exp1(b,n)
  if n == 0
    1
  else
    b * exp1(b, n-1)
  end
end

# another way of raising a base to an exponent
def exp2(b,n)
  if n == 0
    1
  elsif n%2 == 0
    exp2(b, n/2) * exp2(b, n/2)
  else
    b * exp2(b, (n-1)/2) * exp2(b, (n-1)/2)
  end
end

# Ruby's built-in dup method can't handle nested arrays; this method does!
def deep_dup(dup_item)
  result = []

  if !dup_item.any? { |x| x.is_a?(Array)}
    dup_item
  else
    result << Marshal.load( Marshal.dump(dup_item.each { |sub_array| deep_dup(sub_array) }) )
  end

  result[0]
end

# takes in an integer n and returns the first n Fibonacci numbers in an array
def fib_iterative(n)
  fib_seq = [0,1]

  if n == 0
    []
  elsif n < 3
    fib_seq[0..n-1]
  else
    while n > 2
      fib_seq << (fib_seq[-1] + fib_seq[-2])
      n -= 1
    end
  end

  fib_seq
end

# recursively returns the first n Fibonacci numbers in an array
def fib_recursion(n)
  if n == 1
    return [0]
  elsif n == 2
    return [0,1]
  elsif n > 2
    return fib_recursion(n-1) << (fib_recursion(n-1)[-1] + fib_recursion(n-2)[-1])
  end
end

# recursive binary search (http://en.wikipedia.org/wiki/Binary_search)
def bsearch(array, target)
  median = array.size / 2

  if array[median] == target
    return median
  elsif array[median] > target
    bsearch(array[0..median], target)
  else
    bsearch(array[median..-1], target) + array[0...median].size
  end
end

# makes change for an amount in US coin denominations (http://rubyquiz.com/quiz154.html)
def make_change(amt, coins = [25, 10, 5, 1])
  if amt - 25 == 0
    [25]
  elsif amt - 25 > 0
    [25].concat(make_change(amt-25, [25, 10, 5, 1]))
  elsif amt - 10 == 0
    [10]
  elsif amt - 10 > 0
    [10].concat(make_change(amt-10, [25, 10, 5, 1]))
  elsif amt - 5 == 0
    [5]
  elsif amt - 5 > 0
    [5].concat(make_change(amt-5, [25, 10, 5, 1]))
  elsif amt - 1 == 0
    [1]
  elsif amt - 1 > 0
    [1].concat(make_change(amt-1, [25, 10, 5, 1]))
  end
end

# a much shorter way of accomplishing the above!
def make_change2(amt, coins)
  coins.each do |coin|
    if amt - coin == 0
      return [coin]
    elsif amt - coin > 0
      return [coin].concat(make_change2(amt-coin, coins))
    end
  end
end

# performs a merge sort on an array (http://en.wikipedia.org/wiki/Merge_sort)
def mergesort(array)
  if array.size <= 1
    return array
  else
    middle = array.size/2
    left = mergesort(array[0...middle])
    right = mergesort(array[middle..-1])

    return merge(left, right)
  end
end

# merge sort helper method
def merge(left, right)
  result = []

  while (left.size > 0) || (right.size > 0)
    if (left.size > 0) && (right.size > 0)
      if left.first <= right.first
        result << left.shift
      else
        result << right.shift
      end
    elsif left.size > 0
      result << left.shift
    elsif right.size > 0
      result << right.shift
    end
  end
  result
end

# returns all subsets of an array
def subsets(array)
  val_array = []
  val_array << []
  i = 0

  while i < array.count
    j = i + 1
    val_array.push([array[i]])
    while j < array.count
      val_array.push([array[i..j]].flatten)
      val_array.push([array[i], array[j]].flatten)
      val_array.push([array[i], array[j..-1]].flatten)
      val_array.push([array[0..i], array[j]].flatten)
      val_array.push([array[0..i], array[j..-1]].flatten)
      j += 1
    end
    i += 1
  end

  val_array.uniq.sort
end
