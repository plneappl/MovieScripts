# MovieScripts
Some fish-scripts for managing your movie/series-library. Flattening, recovering names, and cleaning file names.

## Usage
You will need the fish-shell (or a compatible one, or port everything to your favourite shell). Fish is available here:
[Fishshell.com](http://fishshell.com/)

### Flatten
This script flattens the (current) directory, i.e. pulls all movies down.
`> ./flatten.fish [directory]`

### Renamer
This script tries to guess a better name for all files in the (current) directory by looking for folders with the same series identifier (i.e. S01E01).
`> ./renamer.fish [directory|file]`
Example:
```
foo/
- baz.S01E01.This.is.a.better.description/
- bar.s01e01.mkv
```
Will turn into
```
foo/
- baz.S01E01.This.is.a.better.description/
- baz.S01E01.This.is.a.better.description.mkv
```
Valid series identifiers on files are 
- s01e01 (not case sensitive)
- 101
- 1023

### Nicer
This script does some cleanup on all filenames in the (current) directory, it:
- replaces dots, dashes, underscores with spaces (`. - _`)
- removes some whatever keywords
- removes braces
- removes leading, duplicate, and trailing spaces
`> ./nicer.fish [directory|file]`

### Recommended Workflow
- for movies: `flatten`, then `nicer`.
- for series: `flatten`, `renamer`, then `nicer`.

## DISCLAIMER
Although all scripts should be quite safe to use, you should probably do a dry run on some of your files first (by commenting out the `mv`-line). I won't restore your old file names or be held responsible in any other way occurring from the use of these scripts.
