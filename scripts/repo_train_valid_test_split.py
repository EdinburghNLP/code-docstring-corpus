#! /usr/bin/python

import sys
import numpy as np
from collections import defaultdict

def pick_repos(repos, repos_count_dict, repos_mean_size, target_size):
    rv = []
    cur_size = 0
    while cur_size < target_size - 0.5 * repos_mean_size:
        repo = repos.pop()
        cur_size += repos_count_dict[repo]
        rv.append(repo)
    return rv

def write_repos(data, metadata, all_repos, repos, out_repos_fs, out_data_fs, out_metadata_fs):
    for repo in repos:
        print >> out_repos_fs, repo

    repo_set = set(repos)
    for i in xrange(len(all_repos)):
        if all_repos[i] in repo_set:
            print >> out_data_fs, data[i].strip()
            print >> out_metadata_fs, metadata[i].strip()

def main():
    np.random.seed(42)
    if len(sys.argv) != 8:
        usage()

    data_fs = open(sys.argv[1])
    metadata_fs = open(sys.argv[2])
    valid_size = int(sys.argv[3])
    test_size = int(sys.argv[4])
    
    out_train_repo_fs = open(sys.argv[5] + ".train", "w")
    out_valid_repo_fs = open(sys.argv[5] + ".valid", "w")
    out_test_repo_fs = open(sys.argv[5] + ".test", "w")

    out_train_data_fs = open(sys.argv[6] + ".train", "w")
    out_valid_data_fs = open(sys.argv[6] + ".valid", "w")
    out_test_data_fs = open(sys.argv[6] + ".test", "w")

    out_train_metadata_fs = open(sys.argv[7] + ".train", "w")
    out_valid_metadata_fs = open(sys.argv[7] + ".valid", "w")
    out_test_metadata_fs = open(sys.argv[7] + ".test", "w")

    data = data_fs.readlines()
    metadata = metadata_fs.readlines()
    if len(metadata) - valid_size - test_size < 0:
        print >> sys.stderr, "Error: not enough data"
        sys.exit(-1)

    src_files = [x.split()[0] for x in metadata]
    repos = ['/'.join(x.split('/')[:3]) for x in src_files]
    repos_count_dict = defaultdict(int)
    for x in repos:
        repos_count_dict[x] = repos_count_dict[x] + 1
    repos_mean_size = np.mean(repos_count_dict.values())

    shuf_uniq_repos = repos_count_dict.keys()
    np.random.shuffle(shuf_uniq_repos)
    
    valid_repos = pick_repos(shuf_uniq_repos, repos_count_dict, repos_mean_size, valid_size)
    test_repos = pick_repos(shuf_uniq_repos, repos_count_dict, repos_mean_size, test_size)
    train_repos = shuf_uniq_repos

    write_repos(data, metadata, repos, train_repos, out_train_repo_fs, out_train_data_fs, out_train_metadata_fs)
    write_repos(data, metadata, repos, valid_repos, out_valid_repo_fs, out_valid_data_fs, out_valid_metadata_fs)
    write_repos(data, metadata, repos, test_repos, out_test_repo_fs, out_test_data_fs, out_test_metadata_fs)

def usage():
    print >> sys.stderr, "Usage:"
    print >> sys.stderr, sys.argv[0], "data-file metadata-file valid-size test-size out-repos-basename out-data-basename out-metadata-basename"
    sys.exit(-1)

if __name__ == '__main__':
    main()

