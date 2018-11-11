#! /bin/sh
xsel -bc
path="~"
fil=""
filname=""
bool=0
echo "enter the output directory path:"
read path
if [ ! -e "$path" ]; then
mkdir $path
fi
echo "do you want to compress the folder:[y\n]"
read bool
function trap_ctrlc()
{
zpath=$(echo $path | rev | cut -d"/" -f1 | rev)
if [ "$bool" =  "y" ] || [  "$bool" = "Y" ]; then
zip -r $zpath $path
fi
exit 2
}
trap "trap_ctrlc" 2
while :
do
fil=$(xclip -selection clipboard -o)
filname=$(echo $fil | rev | cut -d"/" -f1 | rev)
if [ -e "$path/$filname" ]; then
echo "file already exists"
else
cp -R $fil $path
echo $fil "copied to" $path
fi 
xsel -bc
sleep 1
done
