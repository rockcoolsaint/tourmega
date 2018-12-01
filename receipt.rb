class Receipt
  attr_accessor :choice
  def initialize(option)
    @choice = option
  end

  def generate_receipt
    @inputs ||= []
    @outputs ||= []
    @sales_tax ||= 0
    @total ||= 0


    price_list = basket_choice
    puts price_list
    puts 'Select an item from the list'
    items = []
    price_list.each_key { |key| items << key }
    items.each.with_index(1) { |item, index| puts "#{index}. #{item}" }

    # select an item
    print "Select an item by typing a number: "
    item = gets.chomp
    if !item.match(/[1-9]/)
      puts "wrong input. Please select between 1 and 9"
      generate_receipt
    end
    item_choice = items[item.to_i - 1]
    if !price_list.include? item_choice
      puts "The item you chose doesn't exist"
      generate_receipt
    end
    #puts item_choice
    # input quantity
    print "Item quantity?: "
    puts ""
    quantity = gets.chomp

    #@inputs << [item_choice, quantity, price_list[:"#{item_choice}"]]

    total_price = ((price_list[:"#{item_choice}"] * quantity.to_i) + (tax(item_choice, quantity, price_list[:"#{item_choice}"])*20).round / 20.0).round(2)
    # cummulative sales tax per basket
    @sales_tax += tax(item_choice, quantity, price_list[:"#{item_choice}"])
    @total += total_price
    @outputs << [quantity, item_choice, total_price]
    puts "Are you done?  Y/N"
    res = gets.chomp
    if !(res.downcase === "yes" || res.downcase === "y")
      generate_receipt
    else
      @outputs << [(@sales_tax*20).round / 20.0, @total.round(2)]
      
      #@outputs << []
      return basket_one(@outputs)
    end
  end

  def basket_choice
    shopping_basket = @choice

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
  basket_choice = gets.chomp
  if !basket_choice.match(/[1-3]/)
    puts "wrong input, please make sure you type 1, 2, or 3"
    checkout
  end


  basket = Receipt.new(basket_choice)
  basket.generate_receipt
end

checkout
