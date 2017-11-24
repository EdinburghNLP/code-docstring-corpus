#! /usr/bin/python

import sys
import cPickle

def main():
    if len(sys.argv) != 2:
        usage()

    database = cPickle.load(open(sys.argv[1]))
    for e in database:
        print e.name, e.last_commit_sha


def usage():
    print >> sys.stderr, 'Usage:'
    print >> sys.stderr, sys.argv[0], 'pickle-file-name'
    sys.exit(-1)

if __name__ == '__main__':
    main()

