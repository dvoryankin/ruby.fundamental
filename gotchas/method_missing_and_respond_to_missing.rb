require 'ostruct'

class Order
  def user
    @_user ||= OpenStruct.new(name: 'Mike', age: 28, occupation: 'slacker')
  end

  def method_missing(method_name, *arguments, &block)
    if method_name.to_s =~ /user_(.*)/
      user.send($1, *arguments, &block)
    else
      super
    end
  end

  def respond_to?(method_name, include_private = false)
    method_name.to_s.start_with?('user_') || super
  end
end

order = Order.new
#<Order:0x00000001e40948>
order.user_name
#=> "Mike"
order.respond_to?(:user_name)
#  => true
order.method(:user_name)
#NameError: undefined method `user_name' for class `Order'
#
#There is a solution!
# How would you like to solve your #method problem while also using a method with a better name?
# change method name from respond_to? to respond_to_missing?

order = Order.new
#=> <Order:0x00000001c8d678> 
order.user_name
#=> "Mike"
order.respond_to?(:user_name)
#=> true
order.method(:user_name)
#=> #<Method: Order#user_name>