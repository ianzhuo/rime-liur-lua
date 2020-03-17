#!/usr/bin/env python3

import os, sys
import csv

class LanguageDict():

    body = {}
    attributes = {}

    def _decomment(self, csvfile):
        for row in csvfile:
            raw = row.split('#')[0].strip()
            if raw:
                yield raw
            else:
                print(row)

    def __init__(self, filename):
        with open(filename, 'r', newline='') as csvfile:
            temp_dic = {}
            spamreader = csv.reader(self._decomment(csvfile))
            for row in spamreader:
                if (not row[1]):
                    try:
                        attr = row[0].split(':')
                        self.attributes[attr[0]] = attr[1]
                    except IndexError:
                        continue
                else:
                    try:
                        priority = int(row[2])
                    except ValueError:
                        priority = 10

                    temp_dic[row[0]] = (row[1], priority)

        self.body = {k: v for k, v in sorted(temp_dic.items(), key=lambda item: (item[1][0], -item[1][1]))}

dic = LanguageDict(sys.argv[1])


print("---")

for a, v in dic.attributes.items():
    print("{:s}: {:s}".format(a, v))

print("...")

for k, (v, p) in dic.body.items():
    print("{:s}\t{:s}".format(k, v))
