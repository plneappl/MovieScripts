#!/bin/fish
function flatten
  if [ $argv ]
    if [ (count $argv) != 1 ]           #check for only one argument
      exit
    else if [ -d $argv ]                #for directories, we process each file inside
      set searchIn $argv/**.mkv $argv/**.avi $argv/**.ts $argv/**.m4v
      set searchPath $argv
    else                                #is there some other case? file not found or something...  We Don't accept single files.
      exit
    end
  else                                  #no arguments ==> just use base path
    set searchIn **.mkv **.avi **.ts **.m4v
    set searchPath .
  end
  
  for i in $searchIn
    mv $i $searchPath/
  end
end
