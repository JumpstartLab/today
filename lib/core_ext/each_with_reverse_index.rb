module Enumerable
  def each_with_reverse_index
    each_with_index do |item,index|
      countdown_index = length - 1 - index
      yield item, countdown_index if block_given?
    end
  end
end