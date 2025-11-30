#!/usr/bin/env sh

hello () {
	echo "Hello World $1 $2";
}

return_hello () {
	echo "Return vala Hello World $1 $2";
	return 7;
}

hello Harshmeet Singh;

echo "$?";

return_hello sexy butt;

r=$?;

echo "Value returned: $r";
