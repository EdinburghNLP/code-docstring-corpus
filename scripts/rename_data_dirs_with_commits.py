#! /usr/bin/python

import sys
import cPickle
import os

def main():
    if len(sys.argv) != 3:
        usage()

    database = cPickle.load(open(sys.argv[1]))
    commit_dict = {}
    for e in database:
        commit_dict[e.full_name] = e.last_commit_sha
    
    data_dir = sys.argv[2]
    for user_dir in os.listdir(data_dir):
        for repo_dir in os.listdir(data_dir+'/'+user_dir):
           commit = commit_dict.get(user_dir+'/'+repo_dir, 'NA')
           new_name = repo_dir + '_' + commit
           os.rename(data_dir+'/'+user_dir+'/'+repo_dir, data_dir+'/'+user_dir+'/'+new_name)


def usage():
    print >> sys.stderr, 'Usage:'
    print >> sys.stderr, sys.argv[0], 'pickle-file-name data-dir'
    sys.exit(-1)

if __name__ == '__main__':
    main()

