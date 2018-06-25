#! /bin/sh

cat parallel_decl | sed 's/q/qq/g' | sed 's/d/qz/g' > parallel_decl.q
cat parallel_desc | sed 's/q/qq/g' | sed 's/d/qz/g' > parallel_desc.q
cat parallel_bodies | sed 's/q/qq/g' | sed 's/d/qz/g' > parallel_bodies.q


paste -d d parallel_decl.q parallel_desc.q parallel_bodies.q > parallel.all

./repo_train_valid_test_split.py parallel.all parallel_meta 2000 2000 repo_split.repos repo_split.parallel.all repo_split_meta

cat repo_split.parallel.all.test | cut -d d -f 1 | sed 's/qz/d/g' | sed 's/qq/q/g'  > repo_split.parallel_decl.test
cat repo_split.parallel.all.valid | cut -d d -f 1 | sed 's/qz/d/g' | sed 's/qq/q/g' > repo_split.parallel_decl.valid
cat repo_split.parallel.all.train | cut -d d -f 1 | sed 's/qz/d/g' | sed 's/qq/q/g' > repo_split.parallel_decl.train
cat repo_split.parallel.all.test | cut -d d -f 2 | sed 's/qz/d/g' | sed 's/qq/q/g'  > repo_split.parallel_desc.test
cat repo_split.parallel.all.valid | cut -d d -f 2 | sed 's/qz/d/g' | sed 's/qq/q/g' > repo_split.parallel_desc.valid
cat repo_split.parallel.all.train | cut -d d -f 2 | sed 's/qz/d/g' | sed 's/qq/q/g' > repo_split.parallel_desc.train
cat repo_split.parallel.all.test | cut -d d -f 3 | sed 's/qz/d/g' | sed 's/qq/q/g'  > repo_split.parallel_bodies.test
cat repo_split.parallel.all.valid | cut -d d -f 3 | sed 's/qz/d/g' | sed 's/qq/q/g' > repo_split.parallel_bodies.valid
cat repo_split.parallel.all.train | cut -d d -f 3 | sed 's/qz/d/g' | sed 's/qq/q/g' > repo_split.parallel_bodies.train

paste -d" DCNL " repo_split.parallel_decl.test  /dev/null /dev/null /dev/null /dev/null /dev/null repo_split.parallel_desc.test  > repo_split.parallel_decldesc.test
paste -d" DCNL " repo_split.parallel_decl.valid /dev/null /dev/null /dev/null /dev/null /dev/null repo_split.parallel_desc.valid > repo_split.parallel_decldesc.valid
paste -d" DCNL " repo_split.parallel_decl.train /dev/null /dev/null /dev/null /dev/null /dev/null repo_split.parallel_desc.train > repo_split.parallel_decldesc.train

paste -d" DCNL " repo_split.parallel_decl.test  /dev/null /dev/null /dev/null /dev/null /dev/null repo_split.parallel_bodies.test  > repo_split.parallel_declbodies.test
paste -d" DCNL " repo_split.parallel_decl.valid /dev/null /dev/null /dev/null /dev/null /dev/null repo_split.parallel_bodies.valid > repo_split.parallel_declbodies.valid
paste -d" DCNL " repo_split.parallel_decl.train /dev/null /dev/null /dev/null /dev/null /dev/null repo_split.parallel_bodies.train > repo_split.parallel_declbodies.train

./filter_mono_by_repos.py mono_decl mono_bodies mono_meta repo_split.repos.train repo_split.mono_decl repo_split.mono_bodies repo_split_mono_meta

paste -d" DCNL " repo_split.mono_decl /dev/null /dev/null /dev/null /dev/null /dev/null repo_split.mono_bodies > repo_split.mono_declbodies

./filter_additional_parallel_by_repos.py parallel_methods_decl parallel_methods_desc parallel_methods_bodies parallel_methods_meta repo_split.repos.test repo_split.parallel_methods_decl.test repo_split.parallel_methods_desc.test repo_split.parallel_methods_bodies.test repo_split_parallel_methods_meta.test
./filter_additional_parallel_by_repos.py parallel_methods_decl parallel_methods_desc parallel_methods_bodies parallel_methods_meta repo_split.repos.valid repo_split.parallel_methods_decl.valid repo_split.parallel_methods_desc.valid repo_split.parallel_methods_bodies.valid repo_split_parallel_methods_meta.valid
./filter_additional_parallel_by_repos.py parallel_methods_decl parallel_methods_desc parallel_methods_bodies parallel_methods_meta repo_split.repos.train repo_split.parallel_methods_decl.train repo_split.parallel_methods_desc.train repo_split.parallel_methods_bodies.train repo_split_parallel_methods_meta.train

paste -d" DCNL " repo_split.parallel_methods_decl.test  /dev/null /dev/null /dev/null /dev/null /dev/null repo_split.parallel_methods_desc.test  > repo_split.parallel_methods_decldesc.test
paste -d" DCNL " repo_split.parallel_methods_decl.valid /dev/null /dev/null /dev/null /dev/null /dev/null repo_split.parallel_methods_desc.valid > repo_split.parallel_methods_decldesc.valid
paste -d" DCNL " repo_split.parallel_methods_decl.train /dev/null /dev/null /dev/null /dev/null /dev/null repo_split.parallel_methods_desc.train > repo_split.parallel_methods_decldesc.train

paste -d" DCNL " repo_split.parallel_methods_decl.test /dev/null /dev/null /dev/null /dev/null /dev/null repo_split.parallel_methods_bodies.test > repo_split.parallel_methods_declbodies.test
paste -d" DCNL " repo_split.parallel_methods_decl.valid /dev/null /dev/null /dev/null /dev/null /dev/null repo_split.parallel_methods_bodies.valid > repo_split.parallel_methods_declbodies.valid
paste -d" DCNL " repo_split.parallel_methods_decl.train /dev/null /dev/null /dev/null /dev/null /dev/null repo_split.parallel_methods_bodies.train > repo_split.parallel_methods_declbodies.train

./filter_mono_by_repos.py mono_methods_decl mono_methods_bodies mono_methods_meta repo_split.repos.train repo_split.mono_methods_decl repo_split.mono_methods_bodies repo_split_mono_methods_meta

paste -d" DCNL " repo_split.mono_methods_decl /dev/null /dev/null /dev/null /dev/null /dev/null repo_split.mono_methods_bodies > repo_split.mono_methods_declbodies

