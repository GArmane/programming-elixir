tax_rates = [NC: 0.075, TX: 0.08]
orders = [
  [id: 123, ship_to: :NC, net_amount: 100.00],
  [id: 124, ship_to: :OK, net_amount:  35.50],
  [id: 125, ship_to: :TX, net_amount:  24.00],
  [id: 126, ship_to: :TX, net_amount:  44.80],
  [id: 127, ship_to: :NC, net_amount:  25.00],
  [id: 128, ship_to: :MA, net_amount:  10.00],
  [id: 129, ship_to: :CA, net_amount: 102.00],
  [id: 130, ship_to: :NC, net_amount:  50.00],
]

defmodule TaxCalculator do
  defp get_tax_rate(ship_to, tax_rates), do: Keyword.get(tax_rates, ship_to, 0.0)

  defp total(order, tax_rates) do
    net_amount = order[:net_amount]
    tax = get_tax_rate(order[:ship_to], tax_rates)

    net_amount + tax
  end

  def calculate(orders, tax_rates) do
    for order <- orders, do: order ++ [ total_amount: total(order, tax_rates) ]
  end
end

IO.inspect TaxCalculator.calculate orders, tax_rates
