#!/bin/fish
function flatten
  for a in $argv
    if [ -d $a ]                #for directories, we process each file inside
      echo $a is dir
      set searchPath $a
    else if [ $a = '-c' ]
      set copyName '1'
    end
  end
  if [ ! $searchPath ]                                  #no arguments ==> just use base path
    set searchPath .
  end
  set searchIn $searchPath/*/**.mkv $searchPath/*/**.avi $searchPath/*/**.ts $searchPath/*/**.m4v


  for i in $searchIn
    if [ ! -f $i ]
      continue
    end
    set fn (basename $i)
    set extension '.'(echo $fn | sed -e 's:^.*\.::')
    set name (echo $fn | sed -e 's:\.[^\.]*$::')
    
    if [ $copyName ]
      set basedir (basename (dirname $i))
      set name $name.$basedir	
    end

    set destName $name$extension
    set dest $searchPath/$destName
#    echo $dest
    if [ -f $dest ]
      echo file already exists: $dest
      continue
    end
    mv $i $dest
  end
end
