# code-docstring-corpus

This repository contains preprocessed Python functions and docstrings for automated code documentation (code2doc) and automated code generation (doc2code) tasks.
Paper: https://arxiv.org/abs/1707.02275

#### Installation
The dependencies can be installed using `pip`:
```
pip install -r requirements.txt
```

### Details

It includes:
- A parallel corpus of 150370 triples of function declarations, function docstrings and function bodies, with a canonical split in  109108 training triples, 2000 validation triples and 2000 test triples. Each triple is annotated by metadata (repository owner, repository name, source file and line number).
- Two versions of the above corpus reassembled into pairs: (declaration+body, docstring) and (declaration+docstring, body), for  code documentation tasks and code generation tasks, respectively.
- A code-only corpus of 161630 pairs of function declarations and function bodies, annotated with metadata.
- A corpus of docstrings automatically generated from the code-only corpus using Neural Machine Translation, to enable data augmentation by "backtranslation"
- Test and validation outputs of the baseline Neural Machine Translation models.
- An alternate train/validation/test split of the parallel corpus which is "repository-consistent": no repository is split between training, validation or test sets.
- A "repository-consistent" filtered version of the code-only corpus: it only contains fragments which appear in the training set of the above repository.
- Preprocessing scripts used to generate the corpora.


The corpora were assembled by scraping from open source GitHub repository with the GitHub scraper used by Bhoopchand et al. (2016) "Learning Python Code Suggestion with a Sparse Pointer Network" (paper: https://arxiv.org/abs/1611.08307 - code: https://github.com/uclmr/pycodesuggest ) .

The Python code was then preprocessed to normalize the syntax, extract top-level functions, remove comments and semantically irrelevant whitespaces, and separate declarations, docstrings (if present) and bodies. We did not extract classes and their methods.

The data was further sub-tokenized using Sennrich et al. (2016) "Byte Pair Encoding" (paper: https://arxiv.org/abs/1508.07909 - code: https://github.com/rsennrich/subword-nmt ). Finally, we trained baseline Neural Machine Translation models for both the code2doc and the doc2code tasks using Nematus (Sennrich et al. 2017, paper: https://arxiv.org/abs/1703.04357 - code: https://github.com/rsennrich/nematus ). We used the code2doc model to generate the docstring corpus from the code-only corpus.

Extraction scripts require AST Unparser ( https://github.com/simonpercivall/astunparse ), NMT tokenization requires the Moses tokenizer scripts ( https://github.com/moses-smt/mosesdecoder )

### Reference

If you use this corpus for a scientific publication, please cite: Miceli Barone, A. V. and Sennrich, R., 2017 "A parallel corpus of Python functions and documentation strings for automated code documentation and code generation" arXiv:1707.02275 https://arxiv.org/abs/1707.02275
