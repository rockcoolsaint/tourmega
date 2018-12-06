require_relative 'receipt_class'

def checkout
  puts "select shopping basket"
  puts "available options are 1, 2, 0r 3"
  choice = gets.chomp
  if !choice.match(/[1-3]/)
    puts "wrong input, please make sure you type 1, 2, or 3"
    checkout
  end


  #basket = Receipt.new(basket_choice)
  basket = Receipt.new
  price_list = basket.basket_choice(choice)
  puts price_list

  output = basket.generate_receipt(choice, select_items(price_list))
  receipt_output = basket.basket_one(output)
end

def select_items(price_list, input = [])
  inputs ||= input
  puts 'Select an item from the list'
  items = []
  price_list.each_key { |key| items << key }
  items.each.with_index(1) { |item, index| puts "#{index}. #{item}" }

  # select an item
  print "Select an item by typing a number: "
  item = gets.chomp
  if !item.match(/[1-9]/)
    puts "wrong input. Please select between 1 and 9"
    select_items(price_list)
  end
  item_choice = items[item.to_i - 1]
  if !price_list.include? item_choice
    puts "The item you chose doesn't exist"
    select_items(price_list)
  end
  #puts item_choice
  # input quantity
  print "Item quantity?: "
  puts ""
  quantity = gets.chomp

  inputs << [quantity, item_choice, price_list[:"#{item_choice}"]]

  puts "Are you done?  Y/N"
  res = gets.chomp
  if !(res.downcase === "yes" || res.downcase === "y")
    select_items(price_list, inputs)
  else
    return inputs
  end

  #return inputs
end

checkout
