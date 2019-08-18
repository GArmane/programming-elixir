# Arch Linux - 64 bits - Elixir 1.8.2 - Erlang/OTP 22

# elixir -r chain.exs -e "Chain.run(10)"
# {2651, "Result is 10"}

# elixir -r chain.exs -e "Chain.run(100)"
# {3630, "Result is 100"}

# elixir -r chain.exs -e "Chain.run(1000)"
# {10864, "Result is 1000"}

# elixir -r chain.exs -e "Chain.run(10000)"
# {52882, "Result is 10000"}

# elixir -r chain.exs -e "Chain.run(100000)"
# {369464, "Result is 100000"}

# elixir --erl "+P 1000000" -r chain.exs -e "Chain.run(1000000)"
# {3786690, "Result is 1000000"
