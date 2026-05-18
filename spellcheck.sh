#!/bin/bash

export LANG=en_GB.UTF-8

# run spell checker on file
cat $1 | aspell pipe list -d en_GB --home-dir=. -t | \
    # skip first line and only get misspelled words
    awk -F ' ' '{if (NR>1 && NF>1){print $2}}' > .misspelled_words.txt
# and look for them in the file
cat .misspelled_words.txt | \
    while read word; do
	grep -on "\<$word\>" $1;
    done
# error if list of misspelled words is not empty
test "$(cat .misspelled_words.txt | wc -l)" -gt 0 && exit 1
exit 0
