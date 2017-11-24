#! /usr/bin/python

import sys
import ast
import re

import astunparse

# reduce identation to one space (or custom separator) per level
# assumes that the original code uses 4 spaces per level
def reduce_ident(line, ident_separator=" "):
    line = line.rstrip()
    line_all_stripped = line.lstrip()
    n_spaces = len(line) - len(line_all_stripped)
    n_ident = n_spaces / 4
    return (ident_separator * n_ident) + line_all_stripped

def escape_control_strings(s):
    return s.replace("DCQT", "DCQTDCQT").replace("DCNL", "DCQTDCNL")

def inplace_escape_spaces_in_strings(node):
    if isinstance(node, ast.Str):
        node.s = node.s.replace("DCQS", "DCQSDCQS").replace(" DCSP ", " DCQSDCSP ").replace(" DCTB ", " DCQSDCTB ").replace(" ", " DCSP ").replace("\t", " DCTB ")
    else:
        for child in ast.iter_child_nodes(node):
            inplace_escape_spaces_in_strings(child)

def process_function(node, out_decl_fd, out_body_fd, out_meta_fd, input_filename, parent_class_lineno):
    docstr = ast.get_docstring(node)
    if docstr != None:
        return
    inplace_escape_spaces_in_strings(node)
    unparsed_list = astunparse.unparse(node).split('\n')
    n_funcdef_decorators = len(node.decorator_list)
    unparsed_funcdef = unparsed_list[2:3 + n_funcdef_decorators]
    unparsed_body = unparsed_list[3 + n_funcdef_decorators:]
    funcdef = " DCNL ".join([escape_control_strings(line) for line in unparsed_funcdef])
    processed_body = []
    for line in unparsed_body:
        if line == "":
            continue 		# Drop empty lines
        line = escape_control_strings(line)
        line = reduce_ident(line, ident_separator=" DCSP ")
        processed_body.append(line)
    processed_body_str = ' DCNL'.join(processed_body)
    meta_str = input_filename + " " + str(node.lineno) + " " + str(parent_class_lineno)
    if (processed_body_str == "") or (funcdef == ""):
        return
    print >> out_body_fd, processed_body_str
    print >> out_decl_fd, funcdef
    print >> out_meta_fd, meta_str

def process_class(node, out_decl_fd, out_body_fd, out_meta_fd, input_filename, parent_class_lineno):
    for inner_node in node.body:
        if isinstance(inner_node, ast.ClassDef):
            process_class(inner_node, out_decl_fd, out_body_fd, out_meta_fd, input_filename, node.lineno)
        elif isinstance(inner_node, ast.FunctionDef):
            process_function(inner_node, out_decl_fd, out_body_fd, out_meta_fd, input_filename, node.lineno)
            
def process_module(in_fd, out_decl_fd, out_body_fd, out_meta_fd, input_filename):
    module_str = in_fd.read()
    module_ast = ast.parse(module_str)
    for node in module_ast.body:
        if isinstance(node, ast.ClassDef):
            process_class(node, out_decl_fd, out_body_fd, out_meta_fd, input_filename, -1)

def usage():
    print >> sys.stderr, 'Usage:'
    print >> sys.stderr, sys.argv[0], 'out-declarations-file out-bodies-file out-metadata-file < in-files-list'
    sys.exit(-1)

def main():
    if len(sys.argv) < 4:
        usage()

    funcdecl_filename = sys.argv[1]
    bodies_filename = sys.argv[2]
    meta_filename = sys.argv[3]
    funcdecl_fd = open(funcdecl_filename, "w")
    bodies_fd = open(bodies_filename, "w")
    meta_fd = open(meta_filename, "w")

    for line in sys.stdin:
        input_filename = line.strip()
        #print >> sys.stderr, input_filename
        try:
            process_module(open(input_filename), funcdecl_fd, bodies_fd, meta_fd, input_filename)
        except SyntaxError:
            print >> sys.stderr, "Can't parse file:", input_filename
        except:
            print >> sys.stderr, "Can't process file:", input_filename
            print >> sys.stderr, sys.exc_info()[0] 

    print >> sys.stderr, "Done"

if __name__ == '__main__':
    main()

