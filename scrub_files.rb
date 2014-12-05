# This script erases a handful of photos that I didn't want to include in the final project
%w(
42
60
84
85
86
97
122
131
146
187
192
194
202
203
204
205
206
207
208
209
210
211
212
213
220
225
232
).map(&:to_i).map { |i| sprintf('"%04d*"', i) }.each do |pattern|
  `find . -name #{pattern} | xargs rm`
end
