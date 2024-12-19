function ,prefix
  set p $argv[1]
  if [ "$p" = "" ]
    echo missing prefix
    return
  end
  set opt1 $argv[2]
  if [ "$opt1" = "-s" ]
    set space 1
  else
    set space 0  
  end
  for i in *
    if [ "$space" = "0" ]
      mv "$i" "$p$i"
    else 
      mv "$i" "$p $i"
    end
    
  end
end