### Class and method information

|file | description |
|---  |---          |
|class\_\decl | Class declarations |
|class\_\desc | Class docstrings or DCNA if not present |
|class\_\meta | Class metadata. Format: `github/[repo]_[commit_SHA]/[file_path] [declaration_line] [parent_declaration_line]` |
|module\_\desc | Module docstrings or DCNA if not present|
|module\_\meta | Module metadata. Format: `github/[repo]_[commit_SHA]/[file_path]`|

In the class metadata parent\_\declaration\_\line is only meaningful for nested classes, for top-level classes it is set to -1

