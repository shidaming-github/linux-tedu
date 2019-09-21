#!/bin/bash
j=9
e=5
w=9
for i in {1..300}
do
   echo -e   "\033[3;3H$j:$e$w"
   sleep 0.2
   [ $e -eq 0 ] && [ $w -eq 0 ] && let j-- && e=5 && w=9
   [ $w -eq 0 ] && let e-- && w=9
   let w--
done
