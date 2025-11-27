#!/usr/bin/env sh

# Most special characters between these quotes lose their special meaning with the following exceptions:
# $ ` \$ \' \" \\

VAR="ZARA";

# -----------------------------------------------------------------------------------------------------------------
# Single Quotes prevent variable substitution
echo '$VAR owes <-$1500.**>; [ as of (`date +%m/%d`) ]'

# to substitute variable values and to make inverted commas work as expected, then you would need to put your commands in double quotes as follows
echo "$VAR owes <-\$1500.**>; [ as of (`date +%m/%d`) ]"
# -----------------------------------------------------------------------------------------------------------------
