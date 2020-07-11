LIST=(Dock Finder)

for x in $LIST; do
    killall -KILL $x;
done
