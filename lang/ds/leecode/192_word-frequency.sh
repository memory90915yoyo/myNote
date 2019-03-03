#!/bin/sh

"""
Write a bash script to calculate the frequency of each word in a text file words.txt.

For simplicity sake, you may assume:

words.txt contains only lowercase characters and space ' ' characters.
Each word must consist of lowercase characters only.
Words are separated by one or more whitespace characters.
Example:

Assume that words.txt has the following content:
the day is sunny the the
the sunny is is


Your script should output the following, sorted by descending frequency:
the 4
is 3
sunny 2
day 1


example2
 a a  a  a   b
    b  b
4 a
3 b
"""



# Read from the file words.txt and output the word frequency list to stdout.
sed 's/  */ /g' words.txt | tr ' ' '\n' | sed '/^$/d' | sort  | uniq  -c | sort -k1 -r | awk '{print$2, $1}'