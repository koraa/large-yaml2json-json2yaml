# Constant memory yaml2json and json2yaml in C++

This project provides the command line utilities yaml2json
and json2yaml, written in c++.

It aims at supporting the subset of yaml that can be
directly represented in json. Advanced yaml features, like
anchors, NaN, Infinity or tags are not supported, but
a sensible, configurable handling of those may be added in
the future.

## Installation

Install the required packages:

- build-essential
- git

Make sure you have the git submodules checked out:

```sh
git submodule init && git submodule sync && git submodule update
```

And then compile the code:

```sh
make
```

To install copy the binaries to /usr/local/bin or execute this command
which will perform the copy for you.

```sh
sudo make install
```

You can supply `$PREFIX` to use a different installation directory; the
default prefix is `/usr/local.`aaaa

## Usage

```sh
# Convert between yaml & json
yaml2json < myfile.yaml > myfile.json
json2yaml < myfile.json > myfile.yaml

# For very long files you might want a progress bar
# (The pv command needs to be installed)
pv < myfile.yaml | yaml2json > myfile.json
pv < myfile.json | json2yaml > myfile.yaml

# You can also view the json/yaml directly without a temporary file
yaml2json < myfile.yaml | less
json2yaml < myfile.json | less
```

## Why?

Most of the yaml/json conversion tools I found where written
in javascript or ruby; they load the entire JSON/YAML file
into memory, convert it – also in memory – and then print
the result.
Thus the memory requirement of these programs is greater
than the size of the input file plus the size of the output
file.
Given large files, these often run out of memory.

This project utilizes a streaming approach: Reading data,
conversion and writing the output are all done in parallel,
using the same amount of memory, regardless how large the
input file is. The memory requirement is constant around 3MB
for converting either json or yaml files of arbitrary size.

NOTE: yaml2json and json2yaml still need to read each node
in whole, so if you have a 20MB base64 encoded file in your
json, this will need to be red into memory as one piece.

## Status

Stable: This project has been in use for three years without a majour bug.

# LICENSE (Revised BSD)

Written by (karo@cupdev.net) Karolin Varner.

Copyright © (c) 2016-2019, Karolin Varner.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
* Redistributions of source code must retain the above copyright
  notice, this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright
  notice, this list of conditions and the following disclaimer in the
  documentation and/or other materials provided with the distribution.
* Neither the name of the Karolin Varner, Softwear, BV nor the
  names of its contributors may be used to endorse or promote products
  derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL Softwear, BV BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
