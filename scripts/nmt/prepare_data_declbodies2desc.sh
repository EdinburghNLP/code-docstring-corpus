#! /bin/sh

# Insert paths to tools
MOSES=/path/to/moses
BPE=/path/to/bpe
NEMATUS=/path/to/nematus

cat data_ps.declbodies.test | iconv -c --from UTF-8 --to UTF-8 | $MOSES/scripts/tokenizer/tokenizer.perl > data_ps.declbodies2desc.test.tok.db
cat data_ps.declbodies.valid | iconv -c --from UTF-8 --to UTF-8 | $MOSES/scripts/tokenizer/tokenizer.perl > data_ps.declbodies2desc.valid.tok.db
cat data_ps.declbodies.train | iconv -c --from UTF-8 --to UTF-8 | $MOSES/scripts/tokenizer/tokenizer.perl > data_ps.declbodies2desc.train.tok.db

cat data_ps.descriptions.test | iconv -c --from UTF-8 --to UTF-8  | $MOSES/scripts/tokenizer/tokenizer.perl > data_ps.declbodies2desc.test.tok.d
cat data_ps.descriptions.valid | iconv -c --from UTF-8 --to UTF-8 | $MOSES/scripts/tokenizer/tokenizer.perl > data_ps.declbodies2desc.valid.tok.d
cat data_ps.descriptions.train | iconv -c --from UTF-8 --to UTF-8 | $MOSES/scripts/tokenizer/tokenizer.perl > data_ps.declbodies2desc.train.tok.d

$MOSES/scripts/training/clean-corpus-n.perl data_ps.declbodies2desc.train.tok db d data_ps.declbodies2desc.train.tok.clean 2 400

cat data_ps.declbodies2desc.train.tok.clean.db data_ps.declbodies2desc.train.tok.clean.d > data_ps.declbodies2desc.train.tok.clean.merged
$BPE/learn_bpe.py -s 89500 < data_ps.declbodies2desc.train.tok.clean.merged > data_ps.declbodies2desc.digram.model

$BPE/apply_bpe.py -c data_ps.declbodies2desc.digram.model < data_ps.declbodies2desc.train.tok.clean.db > data_ps.declbodies2desc.train.bpe.clean.db
$BPE/apply_bpe.py -c data_ps.declbodies2desc.digram.model < data_ps.declbodies2desc.train.tok.clean.d > data_ps.declbodies2desc.train.bpe.clean.d
$BPE/apply_bpe.py -c data_ps.declbodies2desc.digram.model < data_ps.declbodies2desc.valid.tok.clean.db > data_ps.declbodies2desc.valid.bpe.clean.db
$BPE/apply_bpe.py -c data_ps.declbodies2desc.digram.model < data_ps.declbodies2desc.valid.tok.clean.d > data_ps.declbodies2desc.valid.bpe.clean.d
$BPE/apply_bpe.py -c data_ps.declbodies2desc.digram.model < data_ps.declbodies2desc.test.tok.clean.db > data_ps.declbodies2desc.test.bpe.clean.db

cat data_ps.declbodies2desc.train.bpe.clean.db data_ps.declbodies2desc.train.bpe.clean.d > data_ps.declbodies2desc.train.bpe.clean.merged
$NEMATUS/data/build_dictionary.py data_ps.declbodies2desc.train.bpe.clean.merged


