#! /bin/sh

ln -s data_ps.metadata data_meta_ps.metadata
./find_shuffled_line_nums.py data_ps.all < data_ps.shuf > data_ps.shuflines
./get_lines_by_num.py data_ps.shuflines < data_meta_ps.metadata > data_meta_ps.metadata.shuf

cat data_meta_ps.metadata.shuf | head -2000 > data_ps.metadata.test
cat data_meta_ps.metadata.shuf | head -4000 | tail -2000 > data_ps.metadata.valid
cat data_meta_ps.metadata.shuf | tail -n +4001 > data_ps.metadata.train


