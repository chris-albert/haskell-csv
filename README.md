# haskell-csv

This is a haskell project for working with csv data. Since i haven't found a good cli for csv's i'm going to work on my haskell skills with a fun example.

Current options:
```
$ hcsv -?
hcsv v0.0.1, (C) Chris Albert

csvargs [OPTIONS] [FILE]

Common flags:
  -h --headers          Display headers only
  -c --columns=String   Columns to display
  -s --showargs         Prints parsed arguments
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

Im going to go through this 1 problem at a time and write tests and verify along the way.

### Step 1. Print headers from file
```
$ hcsv "filename.csv"
header1
header2
header3
header4
```

### Step 2. Print headers from stdin
```
$ cat filename.csv > hcsv
header1
header2
header3
header4
```

After making it be able to read from file and stdin, there is a function `handleDataStream` which abstracts this concept.

### Step 3. Get columns
```
$ hcsv -c header1,header2 filename.csv
row1col1,row1col2
row2col1,row2col2
```
