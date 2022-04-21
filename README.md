# Macadamia
Macadamia is a Python-like programming language, it is static instead of dynamic, and it is made for academic purposes.

## Compilation
```bash
$ make clean # clean the build
$ make configure # configure the bison and flex files
$ make # build the compiler
$ make run < input.txt # run the compiler with an input file

# OR

$ make clean; make configure; make # for building
$ make run < input.txt # for running
```
