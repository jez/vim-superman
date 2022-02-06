function vman -d "Read man pages with vim"
  if not count $argv > /dev/null
     echo "What manual page do you want?"
     return 0
   else if not man -w "$argv" > /dev/null
     # Check that manpage exists to prevent visual noise.
     return 1
   end 

   set -l ed $EDITOR 'vim'; and set -l ed $ed[1]
   echo $ed
   $ed -c "SuperMan $argv"
end
