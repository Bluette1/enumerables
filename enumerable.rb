# This implements some enumerable methods similar to the ones that exist in the `Enumerable` module.
module Enumerable # rubocop:todo Metrics/ModuleLength
  def my_each
    each do |item|
      yield item
    end
  end

  def my_each_with_index
    idx = 0
    each do |item|
      yield item, idx
      idx += 1
    end
  end

  def my_select
    selected = []
    each do |item|
      selected.push(item) if yield item
    end
    selected
  end

  # rubocop:todo Metrics/PerceivedComplexity
  # rubocop:todo Metrics/MethodLength
  def my_all?(*arg) # rubocop:todo Metrics/CyclomaticComplexity
    answer = true
    if block_given?
      each do |item|
        unless yield item
          answer = false
          break
        end
      end
    else
      if arg.empty?
        each do |item|
          next unless item.nil? or item === false # rubocop:todo Style/CaseEquality

          answer = false
          return answer
        end
        return answer
      end
      if arg[0].is_a?(Class)
        each do |item|
          next if item.is_a?(arg[0])

          answer = false
          return answer
        end
        return answer
      end

      begin
        each do |item|
          Regexp.compile(arg[0])
          next unless (arg[0] =~ item).nil?

          answer = false
          break
        end
      rescue StandardError => e
        puts 'Invalid regex. Please use a valid regex string', e
        return
      end

    end

    answer
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/PerceivedComplexity

  # rubocop:todo Metrics/PerceivedComplexity
  # rubocop:todo Metrics/MethodLength
  def my_any?(*arg) # rubocop:todo Metrics/CyclomaticComplexity
    answer = false
    if block_given?
      each do |item|
        next unless yield item

        answer = true
        break
      end
    else
      if arg.empty?
        each do |item|
          # rubocop:todo Style/CaseEquality
          next unless !item.nil? or item === true

          # rubocop:enable Style/CaseEquality

          answer = true
          return answer
        end
        return answer
      end
      if arg[0].is_a?(Class)
        each do |item|
          next unless item.is_a?(arg[0])

          answer = true
          return answer
        end
        return answer
      end

      begin
        each do |item|
          Regexp.compile(arg[0])
          next unless arg[0] =~ item

          answer = true
          break
        end
      rescue StandardError => e
        puts 'Invalid regex. Please use a valid regex string', e
        return
      end

    end

    answer
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/PerceivedComplexity

  # rubocop:todo Metrics/PerceivedComplexity
  # rubocop:todo Metrics/MethodLength
  def my_none?(*arg) # rubocop:todo Metrics/CyclomaticComplexity
    answer = true
    if block_given?
      each do |item|
        next unless yield item

        answer = false
        break
      end
      return answer
    else
      if arg.empty?
        each do |item|
          # rubocop:todo Style/CaseEquality
          next if item.nil? or item === false

          # rubocop:enable Style/CaseEquality

          answer = false
          return answer
        end
        return answer
      end
      if arg[0].is_a?(Class)
        each do |item|
          next unless item.is_a?(arg[0])

          answer = false
          return answer
        end
        return answer
      end

      begin
        each do |item|
          Regexp.compile(arg[0])
          next unless arg[0] =~ item

          answer = false
          break
        end
      rescue StandardError => e
        puts 'Invalid regex. Please use a valid regex string', e
        return
      end

    end

    answer
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/PerceivedComplexity

  def my_count
    answer = 0
    each do |item|
      next unless yield item

      answer += 1
    end
    answer
  end

  def my_map
    result = []
    each do |item|
      result.push yield item
    end
    result
  end

  def my_map_accepts_proc(proc)
    result = []
    each do |item|
      result.push proc.call(item)
    end
    result
  end

  def my_map_accepts_proc_and_block(proc)
    return my_map_accepts_proc(proc) if proc.is_a?(Proc)

    result = []
    each do |item|
      result.push yield item
    end
    result
  end

  # rubocop:todo Metrics/PerceivedComplexity
  # rubocop:todo Metrics/MethodLength
  def my_inject(*args) # rubocop:todo Metrics/CyclomaticComplexity
    if args.empty?
      if block_given?
        product = first
        i = 0
        each do |item|
          i += 1
          next if i == 1

          product = yield product, item
        end
        return product
      end
    else
      if block_given?
        product = args[0]

        each do |item|
          product = yield product, item
        end
        return product
      end

      # if symbol is given
      if args.length === 2 # rubocop:todo Style/CaseEquality
        result = args[0]
        each do |item|
          result = result.send(args[1], item)
        end
        return result
      end
      result = first
      i = 0
      each do |item|
        i += 1
        next if i == 1

        result = result.send(args[0], item)
      end
      return result
    end

    product = args[0]
    each do |item|
      product = yield product, item
    end

    product
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/PerceivedComplexity
end
