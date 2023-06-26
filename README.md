# Rune Lisp (language core)

**STAGE-1** is the first version of the compiler written in Assembler x86_64 (AT&T syntax), necessary for the first stage of the compiler bootstrap.

<br>

### Build

```shell

mkdir Rune-Lisp-Language
cd Rune-Lisp-Language

git clone https://github.com/Rune-Lisp-Language/rune-lisp-core.git

cd rune-lisp-core
./make-core.sh

```

<br>

### Usage

```shell

./build/bin/runec-core --src "/path/to/source.rune" --out "/path/to/output-executable"

```
