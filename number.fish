function number
  set i 1
  if [ $argv ]
    set i $argv
  end
  set max (math (ls . | wc -l) + $i - 1)
  set maxLen (string length $max)
  set formatString "%0"$maxLen"d\n"

  for fn in *.*
    set extension '.'(echo $fn | sed -e 's:^.*\.::')
    set nn (printf $formatString $i)$extension
    set i (math $i + 1)
    mv -n $fn $nn
  end
end