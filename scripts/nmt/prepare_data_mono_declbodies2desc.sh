#! /bin/sh

# Insert paths to tools
MOSES=/path/to/moses
BPE=/path/to/bpe
NEMATUS=/path/to/nematus

cat data_mono_ps.declbodies | iconv -c --from UTF-8 --to UTF-8 | $MOSES/scripts/tokenizer/tokenizer.perl > data_mono_ps.declbodies2desc.train.tok.db

$BPE/apply_bpe.py -c data_ps.declbodies2desc.digram.model < data_mono_ps.declbodies2desc.train.tok.db > data_mono_ps.declbodies2desc.train.bpe.db

