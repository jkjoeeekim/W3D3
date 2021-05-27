require 'byebug'

def range(num1, num2)
  return [] if num1 > num2
  return [num1] if num1 == num2

  prev_arr = range(num1, num2 - 1)
  prev_arr << prev_arr[-1] + 1
end

# p range(1,4)
# p range(2,7)
# p range(3,3)
# p range(3,9)
# p range(10,9)

# def exponentiation(base, exp)
#   return nil if exp < 0
#   return 1 if exp == 0
#   return base if exp == 1

#   base * exponentiation(base, (exp - 1))
# end

def exponentiation(base, exp)
  return nil if exp < 0
  return 1 if exp == 0
  return base if exp == 1

  if exp.even?
    (exponentiation(base, exp / 2)**2)
  else
    base * (exponentiation(base, (exp - 1) / 2)**2)
  end
end

# p exponentiation(2, -1)
# p exponentiation(2, 1)
# p exponentiation(2, 2)
# p exponentiation(3, 3)
# p exponentiation(4, 4)
# p exponentiation(4, 5)

# return arg if arg.all? { |ele| !ele.is_a?(Array) }
# create a new return array
#
#
# [1,2,[3]]

def deep_dup(arr)
  return arr if arr.all? { |ele| !ele.is_a?(Array) }

  new_arr = [] # [1,2]
  arr.each do |ele|
    new_ele = ele.dup
    new_arr << if ele.is_a?(Array)
                 deep_dup(new_ele)
               else
                 new_ele
               end
  end
  new_arr
end

# arr = [[1, 3, 5], [2, 5, [2, 4, 6]], [3]]
# other_arr = arr.dup

# p deep_dup([1, 2, [3]])
# p deep_dup([1, 2, [3, 4, 5], [6, 7]])
# new_arr = deep_dup(arr)

# p arr[0].equal?(new_arr[0])
# p arr.equal?(other_arr)

def fibonacci(n)
  return [0] if n == 1
  return [0, 1] if n == 2

  prev_fibs = fibonacci(n - 1)
  prev_fibs << prev_fibs[-1] + prev_fibs[-2]
end

# p fibonacci(1)
# p fibonacci(2)
# p fibonacci(3)
# p fibonacci(4)
# p fibonacci(5)
# p fibonacci(6)

def bsearch(arr, target)
  return nil unless arr.include?(target)

  middle_idx = arr.length / 2
  middle_num = arr[middle_idx]
  return_idx = 0

  return middle_idx if middle_num == target

  if target < middle_num
    return_idx += bsearch(arr[0...middle_idx], target)
  else
    return_idx = middle_idx + bsearch(arr[middle_idx + 1..-1], target) + 1
  end

  return_idx
end

# p bsearch([1, 2, 3], 1) # => 0
# p bsearch([2, 3, 4, 5], 3) # => 1
# p bsearch([2, 4, 6, 8, 10], 6) # => 2
# p bsearch([1, 3, 4, 5, 9], 5) # => 3
# p bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
# p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
# p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil

# [3, 1, 2]
def merge_sort(arr)
  return arr if arr.length == 1

  half_idx = arr.length / 2
  first_half = arr[0...half_idx]
  second_half = arr[half_idx..-1]

  merge(merge_sort(first_half), merge_sort(second_half))
end

def merge(arr1, arr2)
  merged_arr = []

  merged_arr << (arr1[0] <= arr2[0] ? arr1.shift : arr2.shift) until arr1.empty? || arr2.empty?

  merged_arr + arr1 + arr2
end

# p merge_sort([3, 2, 1])
# p merge_sort([5, 8, 12, 93, 1, 3, 2, 7])

def subsets(arr)
  return [arr] unless arr.is_a?(Array)
  return [arr] if arr.empty?

  # return [arr] if arr.length == 1
  # first = arr.shift
  # all_subsets << subsets(first)
  # all_subsets << subsets(arr)

  # [[],[1]] << [2],[1,2] [each, last]  << [last] [each,last]
  # subsets(arr-1) << subsets(arr)[-1]
  all_subsets = [[]]

  arr.each { |ele| all_subsets << [ele] }

  (0...(arr.length-1)).each do |idx1|
    # all_subsets << [arr[idx1]] unless all_subsets.include?(arr[idx1])
    (1...arr.length).each do |idx2|
      if idx2 > idx1 && !all_subsets.include?(arr[idx2])
        # all_subsets << [arr[idx2]]
        all_subsets << arr[idx1..idx2]
      end
    end
  end

  all_subsets
end

p subsets([])         # => [[]]
p subsets([1])        # => [[], [1]]
p subsets([1, 2])     # => [[], [1], [2], [1, 2]]
p subsets([1, 2, 3])  # => [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]

# def subsets2(arr)
#   return [arr] if !arr.is_a?(Array) || arr.empty?

#   all_subsets = [[]]

#   first = arr.shift
#   second = arr.shift
#   if arr.length == 0
#     all_subsets << subsets2(first)
#     all_subsets << subsets2(second) unless second.nil?
#     all subsets << (subsets2(first) + subsets2(second)) unless second.nil?
#   end

#   all_subsets
# end

# p subsets2([])         # => [[]]
# p subsets2([1])        # => [[], [1]]
# p subsets2([1, 2])     # => [[], [1], [2], [1, 2]]
