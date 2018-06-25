#! /usr/bin/python

import sys
import ast
import re

import astunparse

def prettify_docstring(docstr):
    docstr = docstr.replace("DCQT", "DCQTDCQT").replace("DCNL", "DCQTDCNL").replace("DCNA", "DCQTDCNA")
    docstr = docstr.replace("'", "\\'")
    rv_list = []
    for line in docstr.split('\n'):
        line = line.strip()  	# Remove whitespaces on both ends of a line
        if (line == "") or (not any([c.isalnum() for c in line])):
            continue            # Drop empty and completely non-alphanumeric lines (e.g. lines consisting only of separatos like ----------)
        rv_list.append(line)
    unevaluated_pretty_docstring = "'" + " DCNL ".join(rv_list) + "'"
    return unevaluated_pretty_docstring

def escape_control_strings(s):
    return s.replace("DCQT", "DCQTDCQT").replace("DCNL", "DCQTDCNL")

def process_class(node, out_module_desc_fd, out_module_meta_fd, out_class_decl_fd, out_class_desc_fd, out_class_meta_fd, input_filename, parent_class_lineno):
    docstr = ast.get_docstring(node)
    
    unparsed_list = astunparse.unparse(node).split('\n')
    n_classdef_decorators = len(node.decorator_list)
    unparsed_classdef = unparsed_list[2:3 + n_classdef_decorators]

    pretty_docstring = prettify_docstring(docstr) if docstr != None else "DCNA"
    classdef = " DCNL ".join([escape_control_strings(line) for line in unparsed_classdef])    
    meta_str = input_filename + " " + str(node.lineno) + " " + str(parent_class_lineno)
    
    print >> out_class_desc_fd, pretty_docstring
    print >> out_class_decl_fd, classdef
    print >> out_class_meta_fd, meta_str
    
    for inner_node in node.body:
        if isinstance(inner_node, ast.ClassDef):
            process_class(inner_node, out_module_desc_fd, out_module_meta_fd, out_class_decl_fd, out_class_desc_fd, out_class_meta_fd, input_filename, node.lineno)
    

def process_module(in_fd, out_module_desc_fd, out_module_meta_fd, out_class_decl_fd, out_class_desc_fd, out_class_meta_fd, input_filename):
    module_str = in_fd.read()
    module_ast = ast.parse(module_str)
    docstr = ast.get_docstring(module_ast)
    if docstr != None:
        pretty_docstring = prettify_docstring(docstr)
        print >> out_module_desc_fd, pretty_docstring
    else:
        print >> out_module_desc_fd, "DCNA"
    meta_str = input_filename
    print >> out_module_meta_fd, meta_str
    
    for node in module_ast.body:
        if isinstance(node, ast.ClassDef):
            process_class(node, out_module_desc_fd, out_module_meta_fd, out_class_decl_fd, out_class_desc_fd, out_class_meta_fd, input_filename, -1)

def usage():
    print >> sys.stderr, 'Usage:'
    print >> sys.stderr, sys.argv[0], 'out-module-descriptions-file out-module-metadata-file out-class-declarations-file out-class-descriptions-file out-class-metadata-file < in-files-list'
    sys.exit(-1)

def main():
    if len(sys.argv) < 6:
        usage()

    module_descriptions_filename = sys.argv[1]
    module_meta_filename = sys.argv[2]
    class_decl_filename = sys.argv[3]
    class_descriptions_filename = sys.argv[4]
    class_meta_filename = sys.argv[5]
    
    module_descriptions_fd = open(module_descriptions_filename, "w")
    module_meta_fd = open(module_meta_filename, "w")
    class_decl_fd = open(class_decl_filename, "w")
    class_descriptions_fd = open(class_descriptions_filename, "w")
    class_meta_fd = open(class_meta_filename, "w")

    for line in sys.stdin:
        input_filename = line.strip()
        #print >> sys.stderr, input_filename
        try:
            process_module(open(input_filename), module_descriptions_fd, module_meta_fd, class_decl_fd, class_descriptions_fd, class_meta_fd, input_filename)
        except SyntaxError:
            print >> sys.stderr, "Can't parse file:", input_filename
        except:
            print >> sys.stderr, "Can't process file:", input_filename
            print >> sys.stderr, sys.exc_info()[0] 

    print >> sys.stderr, "Done"

if __name__ == '__main__':
    main()

