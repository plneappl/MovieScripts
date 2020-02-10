#!/bin/fish
function flatten
  for a in $argv
    if [ -d $a ]                #for directories, we process each file inside
      echo $a is dir
      set searchPath $a
    else if [ $a = '-c' ]
      set copyName '1'
    else if [ $a = '-C' ]
      set replaceName '1'
    end
  end
  if [ ! $searchPath ]                                  #no arguments ==> just use base path
    set searchPath .
  end
  set extensions .mkv .avi .ts .m4v .mp3 .mp4 .jpg .mpg .srr .wmv .nzb
  for ext in $extensions
    set searchIn $searchIn $searchPath/*/**$ext
  end
#   set searchIn $searchPath/*/**.mkv $searchPath/*/**.avi $searchPath/*/**.ts $searchPath/*/**.m4v $searchPath/*/**.mp3 $searchPath/*/**.mp4


  for i in $searchIn
    if [ ! -f $i ]
      continue
    end
    set fn (basename $i)
    set extension '.'(echo $fn | sed -e 's:^.*\.::')
    set name (echo $fn | sed -e 's:\.[^\.]*$::')
    
    if [ $copyName ]
      set basedir (basename (dirname $i))
      set name $basedir.$name	
    else if [ $replaceName ]
      set basedir (basename (dirname $i))
      set name $basedir
    end

    set destName $name
    set dest $searchPath/$destName$extension
#    echo $dest
    if [ -f $dest ]
      set counter 2
      while [ -f $searchPath/(echo $destName)_$counter$extension ]
        echo file already exists: $searchPath/(echo $destName)_$counter$extension
        set counter (echo "$counter + 1" | bc)
#        continue
      end
      set dest $searchPath/(echo $destName)$counter$extension
    end
#    echo "$dest"    
    mv $i $dest
  end
end
