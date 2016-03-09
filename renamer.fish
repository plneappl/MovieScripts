#!/bin/fish
if [ $argv ]
  if [ (count $argv) != 1 ]           #check for only one argument
    exit
  else if [ -f $argv ]                #files get processed directly, the for loop will loop over exactly one file
    set searchIn $argv
    set searchPath (dirname $argv)
  else if [ -d $argv ]                #for directories, we process each file inside
    set searchIn $argv/*.*
    set searchPath $argv
  else                                #is there some other case? file not found or something...
    exit
  end
else                                  #no arguments ==> just use base path
  set searchIn *.*
  set searchPath .
end



for i in $searchIn                                                          #search for 
  set id (echo $i | sed -e 's:^.*\(s[0-9][0-9]e[0-9][0-9]\).*$:\1:I')       #s01e01
  if [ $id = $i ]
    set id (echo $i | sed -e 's:^.*\([0-9]\)\([0-9]\{2\}\).*$:s0\1e\2:I')     #101
  end
  if [ $id = $i ]
    set id (echo $i | sed -e 's:^.*\([0-9]\{2\}\)\([0-9]\{2\}\).*$:s\1e\2:I')   #1001
  end
  if [ $id = $i ]
    echo "couldn't find a match for:"
    echo "\t$i"
    echo '------------'
    continue
  end
  #to get the extension, delete everything before the point; sed is greedy so this is fine.
  set extension '.'(echo $i | sed -e 's/.*\.//')
  #find all files with our ID, for each, check if it's a directory, if so take that directory's name
  set fullName (for candidate in (find $searchPath/ -iname "*$id*") 
    if [ -d $candidate ] 
      basename $candidate
      break
    end
  end)

  set destination $argv/$fullName$extension
  echo $i
  echo $id
  echo $destination
  echo '------------'
  if [ $destination ]
    mv $i $destination
  end
end