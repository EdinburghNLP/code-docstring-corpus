# code-docstring-corpus V2

The code-docstring-corpus version 2, with class declarations, class methods, module docstrings and commit SHAs

### Details

This corpus contains 148,602 top-level functions and 397,224 class methods with declarations, docstrings and bodies.
We also include "monolingual" code-only top-level functions and class methods, and class declarations (with docstrings if available) and method docstrings.


| directory | description |
|---        |---          |
| classes\_and\_modules | Class declarations and docstrings, method docstrings |
| parallel | Main parallel corpus |
| mono | Code-only corpus of 223,033 top-level functions and 1,121,304 class methods |
| repo_split | Repository-consistent train-valid-test splits of the main parallel corpus + filtered code-only repository corresponding to the training repositories |


### Reference

If you use this corpus for a scientific publication, please cite: Miceli Barone, A. V. and Sennrich, R., 2017 "A parallel corpus of Python functions and documentation strings for automated code documentation and code generation" arXiv:1707.02275 https://arxiv.org/abs/1707.02275
