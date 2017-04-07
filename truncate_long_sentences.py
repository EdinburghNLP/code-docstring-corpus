#! /usr/bin/python

import sys

def main():
    if len(sys.argv) < 2:
        usage()
    max_token_num = int(sys.argv[1])

    for line in sys.stdin:
        tokens = line.split()
        print ' '.join(tokens[:max_token_num])

def usage():
    print >> sys.stderr, 'Usage:'
    print >> sys.stderr, sys.argv[0], 'max-token-number'
    sys.exit(-1)

if __name__ == '__main__':
    main()


