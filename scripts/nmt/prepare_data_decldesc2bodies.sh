#! /bin/sh

# Insert paths to tools
MOSES=/path/to/moses
BPE=/path/to/bpe
NEMATUS=/path/to/nematus

cat data_ps.decldesc.test  | iconv -c --from UTF-8 --to UTF-8 | $MOSES/scripts/tokenizer/tokenizer.perl > data_ps.decldes2bodies.test.tok.dd
cat data_ps.decldesc.valid | iconv -c --from UTF-8 --to UTF-8 | $MOSES/scripts/tokenizer/tokenizer.perl > data_ps.decldes2bodies.valid.tok.dd
cat data_ps.decldesc.train | iconv -c --from UTF-8 --to UTF-8 | $MOSES/scripts/tokenizer/tokenizer.perl > data_ps.decldes2bodies.train.tok.dd

cat data_ps.bodies.test | iconv -c --from UTF-8 --to UTF-8  | $MOSES/scripts/tokenizer/tokenizer.perl > data_ps.decldes2bodies.test.tok.bo
cat data_ps.bodies.valid | iconv -c --from UTF-8 --to UTF-8 | $MOSES/scripts/tokenizer/tokenizer.perl > data_ps.decldes2bodies.valid.tok.bo
cat data_ps.bodies.train | iconv -c --from UTF-8 --to UTF-8 | $MOSES/scripts/tokenizer/tokenizer.perl > data_ps.decldes2bodies.train.tok.bo

$MOSES/scripts/training/clean-corpus-n.perl data_ps.decldes2bodies.train.tok dd bo data_ps.decldes2bodies.train.tok.clean 2 400

cat data_ps.decldes2bodies.train.tok.clean.bo data_ps.decldes2bodies.train.tok.clean.dd > data_ps.decldes2bodies.train.tok.clean.merged
$BPE/learn_bpe.py -s 89500 < data_ps.decldes2bodies.train.tok.clean.merged > data_ps.decldes2bodies.digram.model

$BPE/apply_bpe.py -c data_ps.decldes2bodies.digram.model < data_ps.decldes2bodies.train.tok.clean.dd > data_ps.decldes2bodies.train.bpe.clean.dd
$BPE/apply_bpe.py -c data_ps.decldes2bodies.digram.model < data_ps.decldes2bodies.train.tok.clean.bo > data_ps.decldes2bodies.train.bpe.clean.bo
$BPE/apply_bpe.py -c data_ps.decldes2bodies.digram.model < data_ps.decldes2bodies.valid.tok.dd > data_ps.decldes2bodies.valid.bpe.dd
$BPE/apply_bpe.py -c data_ps.decldes2bodies.digram.model < data_ps.decldes2bodies.valid.tok.bo > data_ps.decldes2bodies.valid.bpe.bo
$BPE/apply_bpe.py -c data_ps.decldes2bodies.digram.model < data_ps.decldes2bodies.test.tok.dd > data_ps.decldes2bodies.test.bpe.dd

cat data_ps.decldes2bodies.train.bpe.clean.bo data_ps.decldes2bodies.train.bpe.clean.dd > data_ps.decldes2bodies.train.bpe.clean.merged
$NEMATUS/data/build_dictionary.py data_ps.decldes2bodies.train.bpe.clean.merged

