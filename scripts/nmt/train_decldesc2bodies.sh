#!/bin/bash

# Insert paths to nematus
NEMATUS=/path/to/nematus


$NEMATUS/nematus/nmt.py \
  --model data_ps.decldesc2bodies.model.npz \
  --datasets data_ps.decldesc2bodies.train.bpe.clean.dd data_ps.decldesc2bodies.train.bpe.clean.bo \
  --valid_datasets data_ps.decldesc2bodies.valid.bpe.dd data_ps.decldesc2bodies.valid.bpe.bo \
  --dictionaries data_ps.decldesc2bodies.train.bpe.clean.merged.json data_ps.decldesc2bodies.train.bpe.clean.merged.json \
  --objective CE \
  --dim_word 400 \
  --dim 800 \
  --n_words_src 89500 \
  --n_words 89500 \
  --maxlen 300 \
  --batch_size 20 \
  --valid_batch_size 1 \
  --optimizer adam \
  --lrate 0.0001 \
  --validFreq 10000 \
  --dispFreq 1000 \
  --saveFreq=30000 \
  --sampleFreq=10000 \
  --use_dropout \
  --dropout_embedding=0.2 \
  --dropout_hidden=0.2 \
  --dropout_source=0.1 \
  --dropout_target=0.1 \
  --encoder_truncate_gradient 200 \
  --decoder_truncate_gradient 200 \
  --reload

