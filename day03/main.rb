#!/usr/bin/env ruby

content = ARGF.read
instruction = /mul\(\d{1,3},\d{1,3}\)|do\(\)|don't\(\)/
instructions = content.scan(instruction)

def part1(instructions)
  instructions.filter { |instr| instr.include?('mul') }.map do |instruction|
    instruction[4..-2].split(',').map(&:to_i).inject(:*)
  end.sum
end

def part2(instructions)
  valid = []
  enabled = true
  instructions.each do |instruction|
    case instruction.split('(')[0]
    when 'mul'
      valid << instruction if enabled
    when 'do'
      enabled = true
    when "don't"
      enabled = false
    end
  end
  part1(valid)
end

puts part1(instructions)
puts part2(instructions)
