# On the first call to puts we are injecting the code representation
# of "name" and  "args" parameters to the quoted expression.
# In the second call, result is expected to be evaluated in run time,
# so when we print it, it is already a resolved expression and not code.
