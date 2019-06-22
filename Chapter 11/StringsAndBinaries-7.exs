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

defmodule Parser do
  defp process_headers(data) do
    String.split(data, ",")
    |> Enum.map(&String.strip/1)
    |> Enum.map(&String.to_atom/1)
  end

  defp process_rows(file, headers) do
    Enum.map IO.stream(file, :line), &(process_row(headers, &1))
  end

  defp process_row(headers, row) do
    values = String.split(row, ",")
    |> Enum.map(&String.strip/1)
    |> Enum.map(&process_value/1)
    Enum.zip(headers, values)
  end

  defp process_value(value) do
    case Float.parse(value) do
      {number, _} -> number
      :error -> value |> String.lstrip(?:) |> String.to_atom
    end
  end

  def read_tax(path) do
    file = File.open!(path, [:read, :utf8])
    headers = process_headers IO.read(file, :line)
    process_rows file, headers
  end
end

tax_rates = [NC: 0.075, TX: 0.08]
TaxCalculator.calculate Parser.read_tax("orders.csv"), tax_rates
