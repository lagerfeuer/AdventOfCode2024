#!/usr/bin/env ruby
lines = ARGF.readlines
data = lines.map(&:chomp).map(&:chars)

XMAS = 'XMAS'.freeze

def check_xmas(data, start_y, start_x, range_y, range_x)
  coords = if !range_x.nil? && !range_y.nil?
             range_x.zip(range_y).map { |xi, yi| [yi, xi] }
           elsif !range_x.nil?
             range_x.map { |xi| [start_y, xi] }
           elsif !range_y.nil?
             range_y.map { |yi| [yi, start_x] }
           end
  coords.map { |yi, xi| data[yi][xi] }.join == XMAS
end

def find_xmas(data, start_y, start_x)
  can_go_right = start_x + XMAS.size <= data[start_y].size
  can_go_left = start_x - XMAS.size + 1 >= 0
  can_go_up = start_y - XMAS.size + 1 >= 0
  can_go_down = start_y + XMAS.size <= data.size

  range_right = (start_x...(start_x + XMAS.size)).to_a
  range_left = (start_x - XMAS.size + 1..start_x).to_a.reverse
  range_up = (start_y - XMAS.size + 1..start_y).to_a.reverse
  range_down = (start_y...(start_y + XMAS.size)).to_a

  found = [
    can_go_right && check_xmas(data, start_y, start_x, nil, range_right),
    can_go_left && check_xmas(data, start_y, start_x, nil, range_left),
    can_go_up && check_xmas(data, start_y, start_x, range_up, nil),
    can_go_down && check_xmas(data, start_y, start_x, range_down, nil),
    can_go_right && can_go_up && check_xmas(data, start_y, start_x, range_up, range_right),
    can_go_right && can_go_down && check_xmas(data, start_y, start_x, range_down, range_right),
    can_go_left && can_go_up && check_xmas(data, start_y, start_x, range_up, range_left),
    can_go_left && can_go_down && check_xmas(data, start_y, start_x, range_down, range_left)
  ]
  found.count(true)
end

def check_x_mas2(data, start_y, start_x)
  diags = [
    [[start_y - 1, start_x - 1], [start_y, start_x], [start_y + 1, start_x + 1]],
    [[start_y + 1, start_x - 1], [start_y, start_x], [start_y - 1, start_x + 1]]
  ]

  return false unless diags.all? do |coords|
    coords.all? do |y, x|
      y >= 0 && x >= 0 && y < data.size && x < data[y].size
    end
  end

  words = diags.map { |coords| coords.map { |y, x| data[y][x] }.join }
  words.all? { |word| %w[MAS SAM].include?(word) }
end

def part1(data)
  xs = data.map.with_index do |row, y|
    row.map.with_index do |_col, x|
      data[y][x] == 'X' ? [y, x] : nil
    end
  end.flatten(1).compact
  xs.map { |y, x| find_xmas(data, y, x) }.sum
end

def part2(data)
  as = data[1..].map.with_index do |row, y|
    row[1..].map.with_index do |_col, x|
      data[y][x] == 'A' ? [y, x] : nil
    end
  end.flatten(1).compact
  as.map { |y, x| check_x_mas2(data, y, x) }.count(true)
end

puts part1(data)
puts part2(data)
