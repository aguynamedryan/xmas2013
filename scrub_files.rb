# This script erases a handful of photos that I didn't want to include in the final project
%w(12 22 30 34 41 42 82 104 114 125).map(&:to_i).map { |i| sprintf('"%04d*"', i) }.each do |pattern|
  `find . -name #{pattern} | xargs rm`
end
