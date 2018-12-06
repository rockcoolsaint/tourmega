require_relative '../receipt_class'

describe "generate_receipt for input [[1, 'book', 12.49], [1, 'music cd', 14.99], [1, 'chocolate bar', 0.85]] spec" do
  input = [[1, 'book', 12.49], [1, 'music cd', 14.99], [1, 'chocolate bar', 0.85]]
  basket = Receipt.new
  output = basket.generate_receipt(1, input)
  expected_output = [[1, 'book', 12.49], [1, 'music cd', 16.49], [1, 'chocolate bar', 0.85], [1.50, 29.83]]
  it 'is true' do
    expect(output).to eq(expected_output)
  end
end

describe "generate_receipt for input [[1, 'imported box of chocolates', 10.00], [1, 'imported bottle of perfume', 47.50]] spec" do
  input = [[1, 'imported box of chocolates', 10.00], [1, 'imported bottle of perfume', 47.50]]
  basket = Receipt.new
  output = basket.generate_receipt(1, input)
  expected_output = [[1, 'imported box of chocolates', 10.50], [1, 'imported bottle of perfume', 54.65], [7.65, 65.15]]
  it 'is true' do
    expect(output).to eq(expected_output)
  end
end

describe "generate_receipt for input [[1, 'imported bottle of perfume', 27.99], [1, 'bottle of perfume', 18.99], [1, 'packet of headache pills', 9.75], [1, 'box of imported chocolates', 11.25]] spec" do
  input = [[1, 'imported bottle of perfume', 27.99], [1, 'bottle of perfume', 18.99], [1, 'packet of headache pills', 9.75], [1, 'imported box of chocolates', 11.25]]
  basket = Receipt.new
  output = basket.generate_receipt(1, input)
  expected_output = [[1, 'imported bottle of perfume', 32.19], [1, 'bottle of perfume', 20.89], [1, 'packet of headache pills', 9.75], [1, 'imported box of chocolates', 11.80], [6.65, 74.63]]
  it 'is true' do
    expect(output).to eq(expected_output)
  end
end
