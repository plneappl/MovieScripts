function ,deldupls
  for i in *.mp4
    set i0 (,basename $i)
    set i1 $i0.webm
    set i2 $i0.mov
    set i3 $i0.m4v
    set i4 $i0.avi
    if [ -f $i1 ]
      echo rm $i1
      rm $i1
    end
    if [ -f $i2 ]
      echo rm $i2
      rm $i2
    end
    if [ -f $i3 ]
      echo rm $i3
      rm $i3
    end
    if [ -f $i4 ]
      echo rm $i4
      rm $i4
    end
  end
end