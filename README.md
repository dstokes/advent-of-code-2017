Advent of Code 2017
===================

**Warning: Spoilers**


Comes with test examples given in problems.

You can install using `stack`:

```bash
$ git clone https://github.com/mstksg/advent-of-code-2017
$ cd advent-of-code-2017
$ stack setup
$ stack install
```

The executable `aoc2017` includes a testing and benchmark suite

```
$ aoc2017 --help
aoc2017 - Advent of Code 2017 challenge runner

Usage: aoc2017 DAY [PART] [-t|--tests] [-b|--bench]
  Run challenges from Advent of Code 2017

Available options:
  DAY                      Day of challenge (1 - 25), or "all"
  PART                     Challenge part (a, b, c, etc.)
  -t,--tests               Run sample tests
  -b,--bench               Run benchmarks
  -h,--help                Show this help text

$ aoc2017 5 b
>> Day 05b
>> [✓] 27720699
```

Benchmarking is implemented using *criterion*

```
$ aoc2017 2 --bench
>> Day 02a
benchmarking...
time                 729.1 μs   (695.0 μs .. 784.2 μs)
                     0.967 R²   (0.926 R² .. 0.995 R²)
mean                 740.4 μs   (711.9 μs .. 783.6 μs)
std dev              116.8 μs   (70.44 μs .. 172.8 μs)
variance introduced by outliers: 89% (severely inflated)

>> Day 02b
benchmarking...
time                 782.4 μs   (761.3 μs .. 812.9 μs)
                     0.983 R²   (0.966 R² .. 0.998 R²)
mean                 786.7 μs   (764.1 μs .. 849.4 μs)
std dev              110.8 μs   (42.44 μs .. 228.5 μs)
variance introduced by outliers: 86% (severely inflated)
```

Test suites run the example problems given in the puzzle description, and
outputs are colorized in ANSI terminals.

```
$ aoc2017 1 --tests
[9] [!35732] $ aoc2017 1 --tests
>> Day 01a
[✓] (3)
[✓] (4)
[✓] (0)
[✓] (9)
[✓] Passed 4 out of 4 test(s)
[✓] 1097
>> Day 01b
[✓] (6)
[✓] (0)
[✓] (4)
[✓] (12)
[✓] (4)
[✓] Passed 5 out of 5 test(s)
[✓] 1188
```

This should only work if you're running `aoc2017` in the project directory.

**To run on actual inputs**, the executable expects inputs to be found in the
folder `data/XX.txt` in the directory you are running in.  That is, the input
for Day 7 will be expected at `data/07.txt`.

To aid in regression testing, the executable will also automatically verify
that your current answers match the ones that have been previously submitted
and confirmed correct.  These are expected in `data/ans/XXpart.txt`.  That is,
the target output for Day 7 (Part 2, `b`) will be expected at
`data/ans/07b.txt`.

