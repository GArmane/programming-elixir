fizz_buzz = fn
  0, 0, _ -> "FizzBuzz"
  0, _, _ -> "Fizz"
  _, 0, _ -> "Buzz"
  _, _, x -> x
end

execute = fn n -> fizz_buzz.(rem(n, 3), rem(n, 5), n) end

IO.puts execute.(10)
IO.puts execute.(11)
IO.puts execute.(12)
IO.puts execute.(13)
IO.puts execute.(14)
IO.puts execute.(15)
IO.puts execute.(16)
