=begin
This implements some enumerable methods similar to the ones that exist in the `Enumerable` module.
=end
module Enumerable
    def my_each
        for item in self
          yield item
        end
      end
  
      def my_each_with_index
          idx = 0
          for item in self
              yield item, idx
              idx += 1
          end
      end
  
      def my_select 
          selected = []
          for item in self
             if yield item
                  selected.push(item)
             end
          end
          selected
      end

      def my_all? *arg
        answer = true
        if block_given?
            for item in self
                if not yield item
                    answer = false
                    break
                end
            end
        else
            if arg.length == 0
                for item in self
                    if item.nil? or item === false
                        answer = false
                        return answer
                    end
                end
                return answer
            end
            if arg[0].is_a?(Class) 
                for item in self
                    next unless not (item.is_a?(arg[0]))
                    answer = false
                    return answer
                end
                return answer
            end

            begin
                for item in self
                    Regexp.compile(arg[0])
                    next unless (arg[0] =~ item).nil?
                    answer = false
                    break  
                end
                
            rescue => exception
                puts "Invalid regex. Please use a valid regex string", exception
                return
            end
        
        end

        answer
    end

    def my_any? *arg
        answer = false
        if block_given?
            for item in self
                next unless yield item
                answer = true
                break
            end
        else
            if arg.length == 0
                for item in self
                    if not item.nil? or item === true
                        answer = true
                        return answer
                    end
                end
                return answer
            end
            if arg[0].is_a?(Class) 
                for item in self
                    next unless item.is_a?(arg[0])
                    answer = true
                    return answer
                end
                return answer
            end

            begin
                for item in self
                    Regexp.compile(arg[0])
                    next unless arg[0] =~ item
                    answer = true
                    break  
                end
                
            rescue => exception
                puts "Invalid regex. Please use a valid regex string", exception
                return
            end
        
        end

        answer
    end

    def my_none? *arg
        answer = true
        if block_given?
            for item in self
                next unless yield item
                answer = false
                break
            end
            return answer
        else
            if arg.length === 0
                for item in self
                    if not (item.nil? or item === false)
                        answer = false
                        return answer
                    end
                end
                return answer
            end
            if arg[0].is_a?(Class) 
                for item in self
                    next unless item.is_a?(arg[0])
                    answer = false
                    return answer
                end
                return answer
            end

            begin
                for item in self
                    Regexp.compile(arg[0])
                    next unless arg[0] =~ item
                    answer = false
                    break  
                end
                
            rescue => exception
                puts "Invalid regex. Please use a valid regex string", exception
                return
            end
        
        end

        answer    
    end

    def my_count
        answer = 0
        for item in self
            next unless yield item
            answer += 1
        end
        answer
    end

    def my_map 
        result = []
        for item in self
            result.push yield item
        end
        result
    end

    def my_map_accepts_proc proc 
        result = []
        for item in self
            result.push proc.call(item)
        end
        result
    end

    def my_map_accepts_proc_and_block proc
        unless proc.is_a?(Proc)  
            result = []
            for item in self
                result.push yield item
            end
            result
        
        else my_map_proc proc

        end
    end

    def my_inject *args
        if args.length == 0
            if block_given?
                product =  self.first
                i = 0
                for item in self
                    i += 1
                    next if i == 1
                    product = yield product, item
                end  
                return product        
            end
        else
            if block_given?
                product =  args[0]

                for item in self
                    product = yield product, item
                end  
                return product        
            end
            
            # if symbol is given
            if args.length === 2
                result = args[0]
                for item in self
                    result = result.send(args[1], item)
                end
                return result
            end
            result = self.first
            i = 0
            for item in self
                i += 1
                next if i == 1
                result = result.send(args[0], item)
            end  
            return result 
        end
        
        product = args[0]
        for item in self
            product = yield product, item
        end

        product
    end
end