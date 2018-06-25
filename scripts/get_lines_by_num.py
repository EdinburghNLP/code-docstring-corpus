#! /usr/bin/python

import sys

def main():
    if len(sys.argv) != 2:
       usage()

    line_ids_fd = open(sys.argv[1])
    lines = sys.stdin.readlines()
    for line_id_str in line_ids_fd:
        line_id = int(line_id_str.strip()) - 1
        print lines[line_id].strip()

def usage():
    print >> sys.stderr, "Usage:"
    print >> sys.stderr, sys.argv[0], "line-nums < src-file"
    sys.exit(-1)

if __name__ == '__main__':
    main()

