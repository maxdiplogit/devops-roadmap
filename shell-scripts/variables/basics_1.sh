#!/usr/bin/env sh

X=10
readonly X
echo "X: $X"

# The below won't work as X is readonly
# X=20
# echo $X

# In order to mathematical operations, we need to use `expr` explicitly in sh shell
# If we normally do $X+3, it would just print 10+3 on terminal, it's basic string concatenation
Y=$(expr $X + 3)
echo "Y: $Y"

# unset is used to remove the variables being tracked in the environment shell
# unset won't work for readonly variables
Z="Zara Ali"
# readonly Z
unset Z
echo $Z
