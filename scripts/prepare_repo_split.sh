./repo_train_valid_test_split.py data_ps.all data_meta_ps.metadata 2000 2000 repo_split.repos repo_split.data_ps.all repo_split.data_ps.metadata

cat repo_split.data_ps.all.test | cut -d d -f 1 | sed 's/qz/d/g' | sed 's/qq/q/g' > repo_split.data_ps.declarations.test
cat repo_split.data_ps.all.valid | cut -d d -f 1 | sed 's/qz/d/g' | sed 's/qq/q/g' > repo_split.data_ps.declarations.valid
cat repo_split.data_ps.all.train | cut -d d -f 1 | sed 's/qz/d/g' | sed 's/qq/q/g' > repo_split.data_ps.declarations.train
cat repo_split.data_ps.all.test | cut -d d -f 2 | sed 's/qz/d/g' | sed 's/qq/q/g' > repo_split.data_ps.descriptions.test
cat repo_split.data_ps.all.valid | cut -d d -f 2 | sed 's/qz/d/g' | sed 's/qq/q/g' > repo_split.data_ps.descriptions.valid
cat repo_split.data_ps.all.train | cut -d d -f 2 | sed 's/qz/d/g' | sed 's/qq/q/g' > repo_split.data_ps.descriptions.train
cat repo_split.data_ps.all.test | cut -d d -f 3 | sed 's/qz/d/g' | sed 's/qq/q/g' > repo_split.data_ps.bodies.test
cat repo_split.data_ps.all.valid | cut -d d -f 3 | sed 's/qz/d/g' | sed 's/qq/q/g' > repo_split.data_ps.bodies.valid
cat repo_split.data_ps.all.train | cut -d d -f 3 | sed 's/qz/d/g' | sed 's/qq/q/g' > repo_split.data_ps.bodies.train

paste -d" DCNL " repo_split.data_ps.declarations.test /dev/null /dev/null /dev/null /dev/null /dev/null repo_split.data_ps.descriptions.test > repo_split.data_ps.decldesc.test
paste -d" DCNL " repo_split.data_ps.declarations.valid /dev/null /dev/null /dev/null /dev/null /dev/null repo_split.data_ps.descriptions.valid > repo_split.data_ps.decldesc.valid
paste -d" DCNL " repo_split.data_ps.declarations.train /dev/null /dev/null /dev/null /dev/null /dev/null repo_split.data_ps.descriptions.train > repo_split.data_ps.decldesc.train

paste -d" DCNL " repo_split.data_ps.declarations.test /dev/null /dev/null /dev/null /dev/null /dev/null repo_split.data_ps.bodies.test > repo_split.data_ps.declbodies.test
paste -d" DCNL " repo_split.data_ps.declarations.valid /dev/null /dev/null /dev/null /dev/null /dev/null repo_split.data_ps.bodies.valid > repo_split.data_ps.declbodies.valid
paste -d" DCNL " repo_split.data_ps.declarations.train /dev/null /dev/null /dev/null /dev/null /dev/null repo_split.data_ps.bodies.train > repo_split.data_ps.declbodies.train

