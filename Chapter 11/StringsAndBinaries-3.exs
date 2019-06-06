
IO.inspect [ 'cat' | 'dog' ] # ['cat', 100, 111, 103]

# R: IEx prints this result because when the input is evaluated,
# we are appending an list to a charlist, leaving the 'cat' element
# untouched
