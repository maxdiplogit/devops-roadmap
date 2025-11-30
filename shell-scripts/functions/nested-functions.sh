#!/usr/bin/env sh

number_one () {
	echo "First Function...";
	number_two;
}

number_two () {
	echo "Second Function...";
}

number_one;
