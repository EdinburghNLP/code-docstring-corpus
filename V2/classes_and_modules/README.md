### Class and method information

|file | description |
|---  |---          |
|class\_decl | Class declarations |
|class\_desc | Class docstrings or DCNA if not present |
|class\_meta | Class metadata. Format: `github/[repo]_[commit_SHA]/[file_path] [declaration_line] [parent_declaration_line]` |
|module\_desc | Module docstrings or DCNA if not present|
|module\_meta | Module metadata. Format: `github/[repo]_[commit_SHA]/[file_path]`|

In the class metadata parent\_declaration\_line is only meaningful for nested classes, for top-level classes it is set to -1

