# Variable me exists because we need a reference to the parent process.
# As each function is a separate process, subsequent calls to Self inside the
# function would return the PID of the running child process, not of the parent.
