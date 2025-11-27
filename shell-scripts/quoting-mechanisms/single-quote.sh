#!/usr/bin/env sh

# All special characters between these quotes lose their special meaning

#------------------------------------------------------------------------------------
# Putting a backslash in front of each special character is tedious and makes the line difficult to read
echo \<-\$1500.\*\*\>\; \(update\?\) \[y\|n\]

# There is an easy way to quote a large group of characters. Put a single quote (') at the beginning and at the end of the string
echo '<-$1500.**>; (update?) [y|n]'
#------------------------------------------------------------------------------------
