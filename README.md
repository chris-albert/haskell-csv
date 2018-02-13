# haskell-csv

This is a haskell project for working with csv data. Since i haven't found a good cli for csv's i'm going to work on my haskell skills with a fun example.

Running: 
```
# From this directory
$ .stack-work/dist/x86_64-osx/Cabal-2.0.1.0/build/haskell-csv-exe/haskell-csv-exe

# or

$ stack exec haskell-csv-exe -- -h test/file.csv
```

Testing:
```
stack test --file-watch
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
