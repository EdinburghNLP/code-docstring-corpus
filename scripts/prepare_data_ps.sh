#! /bin/sh

cat data_ps.declarations | sed 's/q/qq/g' | sed 's/d/qz/g' > data_ps.declarations.q
cat data_ps.descriptions | sed 's/q/qq/g' | sed 's/d/qz/g' > data_ps.descriptions.q
cat data_ps.bodies | sed 's/q/qq/g' | sed 's/d/qz/g' > data_ps.bodies.q

paste -d d data_ps.declarations.q data_ps.descriptions.q data_ps.bodies.q > data_ps.all
sort -R data_ps.all | uniq > data_ps.shuf

cat data_ps.shuf | head -2000 > data_ps.all.test
cat data_ps.shuf | head -4000 | tail -2000 > data_ps.all.valid
cat data_ps.shuf | tail -n +4001 > data_ps.all.train

cat data_ps.all.test | cut -d d -f 1 | sed 's/qz/d/g' | sed 's/qq/q/g' > data_ps.declarations.test
cat data_ps.all.valid | cut -d d -f 1 | sed 's/qz/d/g' | sed 's/qq/q/g' > data_ps.declarations.valid
cat data_ps.all.train | cut -d d -f 1 | sed 's/qz/d/g' | sed 's/qq/q/g' > data_ps.declarations.train
cat data_ps.all.test | cut -d d -f 2 | sed 's/qz/d/g' | sed 's/qq/q/g' > data_ps.descriptions.test
cat data_ps.all.valid | cut -d d -f 2 | sed 's/qz/d/g' | sed 's/qq/q/g' > data_ps.descriptions.valid
cat data_ps.all.train | cut -d d -f 2 | sed 's/qz/d/g' | sed 's/qq/q/g' > data_ps.descriptions.train
cat data_ps.all.test | cut -d d -f 3 | sed 's/qz/d/g' | sed 's/qq/q/g' > data_ps.bodies.test
cat data_ps.all.valid | cut -d d -f 3 | sed 's/qz/d/g' | sed 's/qq/q/g' > data_ps.bodies.valid
cat data_ps.all.train | cut -d d -f 3 | sed 's/qz/d/g' | sed 's/qq/q/g' > data_ps.bodies.train

paste -d" DCNL " data_ps.declarations.test /dev/null /dev/null /dev/null /dev/null /dev/null data_ps.descriptions.test > data_ps.decldesc.test
paste -d" DCNL " data_ps.declarations.valid /dev/null /dev/null /dev/null /dev/null /dev/null data_ps.descriptions.valid > data_ps.decldesc.valid
paste -d" DCNL " data_ps.declarations.train /dev/null /dev/null /dev/null /dev/null /dev/null data_ps.descriptions.train > data_ps.decldesc.train

paste -d" DCNL " data_ps.declarations.test /dev/null /dev/null /dev/null /dev/null /dev/null data_ps.bodies.test > data_ps.declbodies.test
paste -d" DCNL " data_ps.declarations.valid /dev/null /dev/null /dev/null /dev/null /dev/null data_ps.bodies.valid > data_ps.declbodies.valid
paste -d" DCNL " data_ps.declarations.train /dev/null /dev/null /dev/null /dev/null /dev/null data_ps.bodies.train > data_ps.declbodies.train

