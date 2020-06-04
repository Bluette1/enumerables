# This implements some enumerable methods similar to the ones that exist in the `Enumerable` module.
module Enumerable # rubocop:todo Metrics/ModuleLength
  def my_each
    return to_enum(:my_each) unless block_given?

    enum = to_enum
    size.times do |_item|
      yield enum.next
    end
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    idx = 0
    my_each do |item|
      yield item, idx
      idx += 1
    end
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    selected = []
    my_each do |item|
      selected.push(item) if yield item
    end
    selected
  end

  # rubocop:todo Metrics/PerceivedComplexity
  # rubocop:todo Metrics/MethodLength
  def my_all?(arg = nil) # rubocop:todo Metrics/CyclomaticComplexity
    answer = true
    if block_given?
      my_each do |item|
        return false unless yield item
      end
      return answer
    else
      if arg.nil?
        my_each do |item|
          next unless item.nil? or item == false

          return false
        end
        return answer
      end
      if arg.is_a?(Class)
        my_each do |item|
          next if item.is_a?(arg)

          return false
        end
        return answer
      end
      if arg.is_a?(Regexp)
        my_each do |item|
          next unless (arg =~ item).nil?

          return false
        end
        return true
      end
      my_each do |item|
        next if arg.eql? item

        return false
      end
    end
    answer
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/PerceivedComplexity

  # rubocop:todo Metrics/PerceivedComplexity
  # rubocop:todo Metrics/MethodLength
  def my_any?(arg = nil) # rubocop:todo Metrics/CyclomaticComplexity
    answer = false
    if block_given?
      my_each do |item|
        next unless yield item

        return true
      end
    else
      if arg.nil?
        my_each do |item|
          next if item.nil? or item == false

          return true
        end
        return answer
      end
      if arg.is_a?(Class)
        my_each do |item|
          next unless item.is_a?(arg)

          return true
        end
        return answer
      end
      if arg.is_a?(Regexp)
        my_each do |item|
          next unless arg =~ item

          return true
        end
      end

      my_each do |item|
        next unless arg.eql? item

        return true
      end

    end
    answer
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/PerceivedComplexity

  # rubocop:todo Metrics/PerceivedComplexity
  # rubocop:todo Metrics/MethodLength
  def my_none?(arg = nil) # rubocop:todo Metrics/CyclomaticComplexity
    answer = true
    if block_given?
      my_each do |item|
        next unless yield item

        return false
      end
      return answer
    else
      if arg.nil?
        my_each do |item|
          next if item.nil? or item == false

          return false
        end
        return answer
      end
      if arg.is_a?(Class)
        my_each do |item|
          next unless item.is_a?(arg)

          return false
        end
        return answer
      end
      if arg.is_a?(Regexp)
        my_each do |item|
          next unless arg =~ item

          return false
        end
      end
      my_each do |item|
        next unless arg.eql? item

        return false
      end
    end
    answer
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/PerceivedComplexity

  def my_count(arg = nil)
    answer = 0
    if block_given?
      my_each do |item|
        next unless yield item

        answer += 1
      end
    elsif !arg.nil?
      my_each do |item|
        next unless arg == item

        answer += 1
      end

    else
      my_each do |_item|
        answer += 1
      end
    end
    answer
  end

  def my_map
    return to_enum(:my_map) unless block_given?

    result = []
    my_each do |item|
      result.push yield item
    end
    result
  end

  def my_map_accepts_proc(proc)
    return my_map unless proc.is_a?(Proc)

    my_map(&proc)
  end

  def my_map_accepts_proc_and_block(proc, &block)
    return my_map_accepts_proc(proc) if proc.is_a?(Proc)

    my_map(&block)
  end

  def multiply_els(arr)
    arr.my_inject(:*)
  end

  # rubocop:todo Metrics/PerceivedComplexity
  # rubocop:todo Metrics/MethodLength
  def my_inject(*args) # rubocop:todo Metrics/CyclomaticComplexity
    return to_enum(:my_inject) unless block_given? or !args.empty?

    if args.empty?
      if block_given?
        product = first
        i = 0
        my_each do |item|
          i += 1
          next if i == 1

          product = yield product, item
        end
        return product
      end
    else
      if block_given?
        product = args[0]

        my_each do |item|
          product = yield product, item
        end
        return product
      end

      # if symbol is given
      if args.length === 2 # rubocop:todo Style/CaseEquality
        result = args[0]
        my_each do |item|
          result = result.send(args[1], item)
        end
        return result
      end
      result = first
      i = 0
      my_each do |item|
        i += 1
        next if i == 1

        result = result.send(args[0], item)
      end
      return result
    end

    product = args[0]
    my_each do |item|
      product = yield product, item
    end

    product
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/PerceivedComplexity
end
