#!/usr/bin/fish
function nicer
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
      return
    end
  else                                  #no arguments ==> just use base path
    set searchIn *.*
    set searchPath .
  end
    
  #all keywords to delete, case insensitive, spaces instead of [._-]
  set firstDel               german
  set deletions              dubbed x264 bluray web ac3 ac3md rip dts hd readnfo multi 'dd5 1' 'h 264' h264 dub '\(1\)' 
  set deletions $deletions   wmv dvd ts 'blu ray' dd51 'aac2 0' aac avc remux xvid tv avi mp4 'dd2 0' 'read nfo' internal ituneshd
  set deletions $deletions   dvdrip hdtv repack bdrip webrip proper by ger bd 'ddp5 1' '7 1' '5 1' uhd x265 h265 webhd fs ws ma sub jap
  set deletions $deletions   '2 0' anime hevc eac3d amazonuhd 'dd 51' amazn av1 opus eac3 netflixhd dv dsnp truehd atmos
  set deletions $deletions   'DDPA5 1' ac3d untouched amzn webuhd sdr 'ddplus 51' xxx mkv hls hybrid hlg max global msubs 'h 265'
  set deletions $deletions   subbed

  set sedDel "(\b$firstDel\b)"
  for del in $deletions
    set sedDel "$sedDel|(\b$del\b)"
  end

  set replacements           hdr10plus,HDR dl,DL
  
  set firstDeletionChar      '\('
  set deletionChars          '\)' '\[' '\]' "'" ';' '/' '¡' '¦'
  set sedDelChars "($firstDeletionChar)"
  for del in $deletionChars
    set sedDelChars "$sedDelChars|($del)"
  end
  
  for i in $searchIn
    if [ ! -f $i ]
      continue
    end
    set fn (basename $i)
    echo $fn
    set extension '.'(echo $fn | sed -e 's:^.*\.::' | tr '[:upper:]' '[:lower:]')
    set name ' '(echo $fn | sed -e 's:\.[^\.]*$::')' '
        
    #replace dots, dashes and underscores
    set nicerName (echo $name | sed -E 's:[._–,-]+: :gI')
  
    #remove all keywords
    set nicerName (echo $nicerName | sed -E "s:$sedDel: :gI")

    for e in $replacements
      echo $e | read -d , s_from s_to
      set nicerName (echo $nicerName | sed -r "s: $s_from : $s_to :gI")
    end
  
    #some special chars
    set nicerName (echo $nicerName | sed -E "s:$sedDelChars::gI")
  
    #uppercase each word
    set nicerName (echo $nicerName | sed -r 's:\<.:\U&:g')
  
    #detect ID
    set id       (echo $nicerName | sed -r 's:^.* ep ([0-9][0-9]) .*$: S01E\1 :I')
    set origId   (echo $nicerName | sed -r 's:^.* (ep [0-9][0-9]) .*$: \1 :I')
    if [ $id = $nicerName ]
      set id     (echo $nicerName | sed -r 's:^.* season ([0-9]) e([0-9][0-9]) .*$: S0\1E\2 :I')       #season 1 e01
      set origId (echo $nicerName | sed -r 's:^.* (season [0-9] e[0-9][0-9]) .*$: \1 :I')
    end
    if [ $id = $nicerName ]
      set id     (echo $nicerName | sed -r 's:^.* s([0-9][0-9])e([0-9][0-9]) .*$: S\1E\2 :I')       #s01e01
      set origId (echo $nicerName | sed -r 's:^.* (s[0-9][0-9]e[0-9][0-9]) .*$: \1 :I')
    end
    if [ $id = $nicerName ]
      set id     (echo $nicerName | sed -r 's:^.* s([0-9][0-9]) e([0-9][0-9]) .*$: S\1E\2 :I')       #s01 e01
      set origId (echo $nicerName | sed -r 's:^.* (s[0-9][0-9] e[0-9][0-9]) .*$: \1 :I')
    end
    if [ $id = $nicerName ]
      set id     (echo $nicerName | sed -r 's:^.* ([0-9])x([0-9]{2}) .*$: S0\1E\2 :I')               #1x01
      set origId (echo $nicerName | sed -r 's:^.* ([0-9]x[0-9]{2}) .*$: \1 :I')
    end
    if [ $id = $nicerName ]
      echo "ID couldn't be detected"
    else if test ! "$origId" = "$id"
      echo '"'$origId'" -> "'$id'"'
    end
  
    #replace ID with S01E01
    set nicerName (echo $nicerName | sed -r "s:$origId:$id:")
  
    #remove all duplicate space
    set nicerName (echo $nicerName | sed -r 's: +: :g')
  
    #remove space at the start/end of the file name
    set nicerName (echo $nicerName | sed -r 's:^ +::')
    set nicerName (echo $nicerName | sed -r 's: +$::')
  
    set destination $searchPath/$nicerName$extension
 
    if [ "' $nicerName '" = "'$name'" ]
      # do nothing
      echo '> unchanged'
      echo '------------'

    else if [ $nicerName ]
      #what we are going to do
      echo $nicerName$extension
      echo '------------'
    
      #do it
      if [ (echo "' $nicerName '" | tr '[:upper:]' '[:lower:]') = (echo "'$name'" | tr '[:upper:]' '[:lower:]') ]
        set destination2 $searchPath/_$nicerName$extension
        mv -n $i $destination2
        mv -n $destination2 $destination
      else
        mv -n $i $destination
      end    
    else 
      echo "Something went wrong... We didn't rename the file because we would have renamed it to $nicerName (whoops!)"
      echo '------------'
    end
  end
end

