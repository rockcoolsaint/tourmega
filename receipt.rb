class Receipt
  def initialize
  end

  def generate_receipt(choice, inputs)
    @inputs ||= inputs
    @outputs ||= []
    @sales_tax ||= 0
    @total ||= 0

    inputs.each do |input|
      total_price = ((input[2] * input[1].to_i) + (tax(input[0], input[1].to_i, input[2])*20).round / 20.0).round(2)
      @sales_tax += tax(input[0], input[1].to_i, input[2])
      @total += total_price
      @outputs << [input[1], input[0], total_price]
    end
    @outputs << [(@sales_tax*20).round / 20.0, @total.round(2)]
    return basket_one(@outputs)
  end

  def basket_choice(choice)
    shopping_basket = choice

    case shopping_basket
    when "1"
      return {'book': 12.49,
      'music cd': 14.99,
      'chocolate bar': 0.85}
    when "2"
      return {'imported box of chocolates': 10.00,
      'imported bottle of perfume': 47.50,}
    when "3"
      return {'imported bottle of perfume': 27.99,
      'bottle of perfume': 18.99,
      'packet of headache pills': 9.75,
      'box of imported chocolates': 11.25}
    end
  end

  def basket_one(outputs)
    output = outputs
    puts "Basket receipt"
    puts "=============="
    #puts output
    output.each do |item|
      if item != output.last
        item.each do |prop|
          if prop != item.last
            print "#{prop}, "
          else
            print "#{prop}"
          end
        end
        puts
      else
        item.each do |prop|
          if prop != item.last
            puts "Sales Taxes: #{prop}"
          else
            puts "Total: #{prop}"
          end
        end
      end
    end
    exit(0) 
  end

  def tax(item, quantity, item_price)
    #sales_tax

    if !"#{item}".match(/\b(?:book|chocolate|chocolates|pills)\b/i)
      sales_tax = 0.1 * item_price.to_f  * quantity.to_i
    else
      sales_tax = 0
    end 
    #import_duty
    regex = /.*imported.*/
    if item.match(regex)
      import_duty = 0.05 * item_price.to_f * quantity.to_i
    else
      import_duty = 0
    end

    return sales_tax + import_duty
  end
end


#basket

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

  basket.generate_receipt(choice, select_items(price_list))
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

  inputs << [item_choice, quantity, price_list[:"#{item_choice}"]]

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
