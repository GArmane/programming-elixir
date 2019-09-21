defmodule My do
  defmacro unless(condition, clauses) do
    do_clause = Keyword.get clauses, :do
    else_clause = Keyword.get clauses, :else

    quote do
      case unquote(condition) do
        val when val in [true] -> unquote(else_clause)
        _ -> unquote(do_clause)
      end
    end
  end
end

defmodule Test do
  require My

  My.unless 1==2 do
    IO.puts "1 != 2"
  else
    IO.puts "1 == 2"
  end
end
