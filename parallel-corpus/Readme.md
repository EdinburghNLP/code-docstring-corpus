# Dataset Descriptions

## Special Tokens Used in the dataset

`DCNL` stands for **newline**

`DCSP` stands for a **space** that is *either* in the leading identation of a line(one token per nesting level) *or* inside a string constatn

### Reasons for using special tokens

Most seq2seq tools and their tokenizers expect one example per line and collapse consecutive whitespaces, while in Python each code snippet can span multiple lines and consecutive whitespaces in the identation and inside string constants are syntactically or semantically different and therefore should not be collapsed.

### Measures to escape the tokens above

There are cases that the token string appear in the source code themselves. In such case, a script is used for pre-processing: https://github.com/EdinburghNLP/code-docstring-corpus/blob/master/scripts/extract_funcdefs_and_docstrings.py#L30


## Letter `d` escape in the `data_ps.all` dataset file

In this dataset, `d'` and `'d` are used for mark the start and end of the description. In this way, we need to escape all the letter `d` in the dataset so that we can successfully split the dataset into a fixed number of columns.

Here we use `qz` to escape all the letter `d` in the dataset. You may wish to restore it back after splitting this dataset using `'d` and `d'` as tokens. Since we acknowledge that string `qz` will appear in very low probability both in Python scripts and in common English language, we are safe to use this escape.
