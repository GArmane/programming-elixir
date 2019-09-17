# Node 1: node_one@GArmane-NBArch
# Node 2: node_two@GArmane-NBArch

# Node1: fun = fn -> IO.puts(Enum.join(File.ls!, ",")) end
#
# Node1: spawn fun
# >>> file1-1,file1-2
# >>> PID<0.121.0>
#
# Node1: Node.spawn :"node_two@GArmane-NBArch", fun
# >>> PID<11069.116.0>
# >>> file2-1,file2-2
