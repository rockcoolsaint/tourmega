require_relative '../receipt_class'

describe 'generate_receipt spec' do
  input = [[1, 'book', 12.49], [1, 'music cd', 14.99], [1, 'chocolate bar', 0.85]]
  basket = Receipt.new
  output = basket.generate_receipt(1, input)
  expected_output = [[1, 'book', 12.49], [1, 'music cd', 16.49], [1, 'chocolate bar', 0.85], [1.50, 29.83]]
  it 'is true' do
    expect(output).to eq(expected_output)
  end
end
