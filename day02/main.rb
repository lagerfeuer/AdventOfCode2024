#!/usr/bin/env ruby
lines = ARGF.readlines
data = lines.map(&:split).map { |l| l.map(&:to_i) }

def safe?(line)
  diffs = line[1..].zip(line).map { |a, b| a - b }
  diffs.all? { |d| d >= 1 && d <= 3 } || diffs.all? { |d| d <= -1 && d >= -3 }
end

def part1(data)
  data.filter { |l| safe?(l) }.count
end

# Creating a new array is not efficient, but it's fast enough for this challenge
def part2(data)
  data.filter { |l| l.each_with_index.map { |_, i| safe?(l.dup.tap { |a| a.delete_at(i) }) }.any? }.count
end

puts part1(data)
puts part2(data)
