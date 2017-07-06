#! /bin/sh

./filter_mono_by_repos.py data_mono_ps.declarations data_mono_ps.bodies data_mono_ps.metadata repo_split.repos.train repo_split.data_mono_ps.declarations repo_split.data_mono_ps.bodies repo_split.data_mono_ps.metadata

paste -d" DCNL " repo_split.data_mono_ps.declarations /dev/null /dev/null /dev/null /dev/null /dev/null repo_split.data_mono_ps.bodies > repo_split.data_mono_ps.declbodies

