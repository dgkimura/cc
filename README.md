# cc

[![Build Status](https://travis-ci.org/dgkimura/cc.svg?branch=master)](https://travis-ci.org/dgkimura/cc)


## Build
You can use CMake to generate MakeFiles for this project. You will also need flex/bison.
```
$ mkdir build && cd build
$ cmake ..
$ make
```

## Usage
```
$ cat <<EOF > code.c
int factorial(int n)
{
    int i, result;
    for (i=1, result=0; i<=n; i++)
    {
        result *= i;
    }
    return result;
}
EOF
$ cc code.c
```
