#!/usr/bin/env ruby
lines = ARGF.readlines
a, b = lines.map(&:split).flatten.map(&:to_i).partition.with_index { |_, idx| idx.odd? }.map(&:sort)

def part1(left, right)
  left.zip(right).map { |x, y| (x - y).abs }.sum
end

def part2(left, right)
  occurences = right.tally
  left.map { |x| x * (occurences[x] || 0) }.compact.sum
end

puts part1(a, b)
puts part2(a, b)
