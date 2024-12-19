function fixSingleDirs
  for i in */
    set singleDir $i/*
    if [ 1 -eq (count $singleDir) ]; and test -d $singleDir
      mv $singleDir/* $i/
      rmdir $singleDir
    end
  end
end