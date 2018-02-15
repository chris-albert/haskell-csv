# haskell-csv

This is a haskell project for working with csv data. Since i haven't found a good cli for csv's i'm going to work on my haskell skills with a fun example.

Current options:
```
$ hcsv -?
hcsv v0.0.2, (C) Chris Albert

csvargs [OPTIONS] [FILE]

Common flags:
  -h --headers          Display headers only
  -c --columns=String   Columns to display
  -s --showargs         Prints parsed arguments
  -n --noheaders        Removes headers from output
  -w --width=INT        Width of each column
  -? --help             Display help message
  -V --version          Print version information
     --numeric-version  Print just the version number
```

Running: 
```
# From this directory
$ stack exec haskell-csv-exe -- -h test/file.csv
# or
$ cat test/file.csv | stack exec haskell-csv-exe -- -h
```

Testing:
```
$ stack test --file-watch
```

Building:
```
$ stack build
# Ouputs bin to /Users/chrisalbert/git/haskell-csv/.stack-work/install/x86_64-osx/lts-10.5/8.2.2/bin
```

