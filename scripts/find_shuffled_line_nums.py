#! /usr/bin/python

import sys

def main():
    if len(sys.argv) != 2:
       usage()

    line_dict = {}
    unshuf_fd = open(sys.argv[1])
    for i, line in enumerate(unshuf_fd):
        line = line.strip()
        line_dict[line] = i

    for i, line in enumerate(sys.stdin):
        line = line.strip()
        if line not in line_dict:
            print >> sys.stderr, "Can't find %s shuffled line" % i
            print "0"
        else:
            print (line_dict[line] + 1)

def usage():
    print >> sys.stderr, "Usage:"
    print >> sys.stderr, sys.argv[0], "unshuffled-file < shuffled-file"
    sys.exit(-1)

if __name__ == '__main__':
    main()

