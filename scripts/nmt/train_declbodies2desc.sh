#!/bin/bash

# Insert paths to nematus
NEMATUS=/fs/meili0/amiceli/nematus-dev-tiedembeddings-truncategradient


$NEMATUS/nematus/nmt.py \
  --model data_ps.declbodies2desc.model.npz \
  --datasets data_ps.declbodies2desc.train.bpe.clean.db data_ps.declbodies2desc.train.bpe.clean.d \
  --valid_datasets data_ps.declbodies2desc.valid.bpe.db data_ps.declbodies2desc.valid.bpe.d \
  --dictionaries data_ps.declbodies2desc.train.bpe.clean.merged.json data_ps.declbodies2desc.train.bpe.clean.merged.json \
  --objective CE \
  --dim_word 500 \
  --dim 500 \
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
  --reload

