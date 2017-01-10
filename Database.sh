#!/bin/bash -x
shopt -s extglob
if [ ! -d dbengine ]
then 
mkdir dbengine
mkdir dbengine/metadata
mkdir dbengine/databases

fi




function update 
{
clear
printf '\t\t\t\t *---Database Engine---*\t\t\t\t '; 
echo updating  table $2
echo ____________________________
while true
do
echo please enter primary key 
read k


va=`more ./dbengine/databases/$1/$2 | awk -v x=$k '{ if ($1 == x) print $0;}'`
if [[ "$va" != "" ]]
then
##

count= wc -w < ./dbengine/metadata/$1/$2 



no=`wc -w < ./dbengine/metadata/$1/$2`

 for i in `seq 1 $no`
do
echo please enter field number $i 
while true
do
 read value

var=`cut -f $i -d ' '  ./dbengine/metadata/$1/$2 `
var2=`more ./dbengine/databases/$1/$2  | awk -v x=$value '{ if ($1 == x) print $0;}'`
while true
do
if [[ $i -eq 1 ]]
 then

    if [[ $value = "" ]]
     then 
       echo "primary key can't be null try again"

        read value 

     elif [[ "$var2" != "" ]]
    
     then  echo "primary key already exists try again"
var2=""
        read value 

         else break

     




     fi


else break
 fi
done

if [[ $var = int ]]

then 
case $value in 

+([[:digit:]]))
arr[i]=$value
break
;;
*) echo "wrong data type please inter int"

esac




else 
arr[i]=$value
break

fi 


done

done 


##

s="${arr[@]}" 
line=`more ./dbengine/databases/$1/$2  | awk -v x=$k '{ if ($1 == x) print $0;}'` 
sed s/"$line"/"$s"/ ./dbengine/databases/$1/$2>temp3 && mv temp3 ./dbengine/databases/$1/$2

break


else echo "key doesnt exist ..please try again" 
fi
done




select choice in "update another row" "previous menu" "go to main menu"
do
case $REPLY in
1) update $1 $2
;;
2) edittable $1 $2;;
3) main 
;; 
*) echo wrong choice 
esac
done









}




function insert 
{
clear 
printf '\t\t\t\t *---Database Engine---*\t\t\t\t '; 
echo inserting into table $2
echo ____________________________






































no=`wc -w < ./dbengine/metadata/$1/$2`

 for i in `seq 1 $no`
do
echo please enter field number $i 
while true
do
 read value

var=`cut -f $i -d ' '  ./dbengine/metadata/$1/$2`
var2=`more ./dbengine/databases/$1/$2 | awk -v x=$value '{ if ($1 == x) print $0;}'`
while true
do
if [[ $i -eq 1 ]]
 then

    if [[ $value = "" ]]
     then 
       echo "primary key can't be null try again"

        read value 

     elif [[ "$var2" != "" ]]
    
     then  echo "primary key already exists try again"
var2=""
        read value 

         else break

     




     fi


else break
 fi
done

if [[ $var = int ]]

then 
case $value in 

+([[:digit:]]))
arr[i]=$value
break
;;
*) echo "wrong data type please inter int"

esac




else 
arr[i]=$value
break

fi 


done

done 











 printf "%s " "${arr[@]}" >> ./dbengine/databases/$1/$2
printf "%s\n "  >> ./dbengine/databases/$1/$2


select choice in "update another row" "previous menu" "go to main menu"
do
case $REPLY in
1) update $1 $2
;;
2) edittable $1 $2;;
3) main 
;; 
*) echo wrong choice 
esac
done
}



-x
function display {
clear
printf '\t\t\t\t *---Database Engine---*\t\t\t\t '; 
select choice in "show row from table $2" "show table $2"
do
case $REPLY in
1) clear 
printf '\t\t\t\t *---Database Engine---*\t\t\t\t '; 
echo please enter primary key of the row you want to display
read key 


#if grep $key ./dbengine/databases/$1/$2>/dev/null

#if more ./dbengine/databases/$1/$2 | awk '$1 == $key'
 var=`more ./dbengine/databases/$1/$2 | awk -v x=$key '{ if ($1 == x) print $0;}'`
if [[ "$var" != "" ]]

then
clear 
printf '\t\t\t\t *---Database Engine---*\t\t\t\t ';
echo table $1
echo __________________________________________ 
grep $key ./dbengine/databases/$1/$2 | column -t -s $'\t'
echo __________________________________________ 
else echo key not fount try again 
fi 
#echo 'want to go back ? y/n' 
#read ans 
#if [[ $ans = y ]]
#then main  
#fi

echo choose from the following
select choice in  "previous menu" "go to main menu"
do
case $REPLY in
1) edittable $1 $2
;;
2) main
 
;; 
*) echo wrong choice 
esac
done

;;
2)

clear 
printf '\t\t\t\t *---Database Engine---*\t\t\t\t '; 
count=`wc -w < ./dbengine/metadata/$1/$2`

   # more ./dbengine/databases/$2/$1 | column -t $count  -s $'\t' 
echo table $1
echo __________________________________________ 
 column -s" " -t $count  ./dbengine/databases/$1/$2
echo __________________________________________
#echo 'want to go back? y/n' 
#read ans 
#if [[ $ans = y ]]
#then main  
#fi

 





count=` wc -w < ./dbengine/metadata/$1/$2`
echo $count
#column -t `$count`  -s  ./dbengine/databases/$1/$2

echo choose from the following
select choice in  "previous menu" "go to main menu"
do
case $REPLY in
1) edittable $1 $2
;;
2) main
 
;; 
*) echo wrong choice 
esac
done

;;
*) echo $REPLY is not a choice 
;;
esac
done 
echo choose from the following
select choice in  "previous menu" "go to main menu"
do
case $REPLY in
1) edittable $1 $2
;;
2) main
 
;; 
*) echo wrong choice 
esac
done


}

 function delete 
{
clear
printf '\t\t\t\t *---Database Engine---*\t\t\t\t ';
echo choose from the following 

select choice in "Delete row from table $1" "delete table $1"
do
case $REPLY in
1) clear 
echo please enter the primary key of row to be deleted 
while true
do
read pk 
#if  grep $pk ./dbengine/databases/$1/$2>/dev/null 
 
 var2=`more ./dbengine/databases/$2/$1 | awk -v x=$pk '{ if ($1 == x) print $0;}'`
if [[ "$var2" != "" ]]

then 
sed /$pk/d ./dbengine/databases/$1/$2> temp && mv temp ./dbengine/databases/$1/$2 

sleep 2

echo row deleted successfully 
sleep 2
main 

else echo  primary key doesnt exist
fi
done

;; 
2)  rm ./dbengine/metadata/$1/$2  
   rm ./dbengine/databases/$1/$2
echo table $2 was deleted successfully 
sleep 2
main 
;;


*) echo $REPLY is not one of the choices.
;;
esac 
done

 }



function showtables
{ 
clear 
printf '\t\t\t\t *---Database Engine---*\t\t\t\t ';
echo Type table name from the following to edit :
select choice in `ls ./dbengine/databases/$1`
do

while [ ! -e dbengine/databases/$1/$REPLY ]
do
echo database entered doesnt exist ..try again
sleep 2
showtables $1 $REPLY

 




done
break
 done 
edittable  $1 $REPLY

};



function createtable 
{ 
clear
printf '\t\t\t\t *---Database Engine---*\t\t\t\t ';
echo please entre table name 
read tname

if [ ! -e ./dbengine/databases/$1/$tname ]
then 
touch ./dbengine/databases/$1/$tname
touch ./dbengine/metadata/$1/$tname
touch ./dbengine/databases/$1/temp1
touch ./dbengine/metadata/$1/temp2

 else echo table already exists ..try again 
sleep 1

createtable $1
fi

echo please enter number of columns 
read col
 echo please entre the name of the primary key column first
while [ $col -gt 0 ]
do
echo please entre the coloumn name





while true
do 
read colname
if grep $colname ./dbengine/databases/$1/temp1
then echo column already exists please try again
continue
else

echo "$colname">>"./dbengine/databases/$1/temp1" 
break 
 fi
done
echo -e "please choose data_type of coloumn\n" 
select choice in int str
do
case $REPLY in
1) echo "$choice">>"./dbengine/metadata/temp2"
break
;; 
2) echo "$choice">>"./dbengine/metadata/temp2"
break
;;

*) echo $REPLY is not one of the choices.

;;
esac
done
#echo "$coltype">>"./databases/$1/temp2"  
let col=$col-1
done
cat ./dbengine/databases/$1/temp1 | tr "\n" " " > ./dbengine/databases/$1/$tname
cat ./dbengine/metadata/$1/temp2 | tr "\n" " " > ./dbengine/metadata/$tname 
rm ./dbengine/databases/$1/temp1
rm ./dbengine/metadata/$1/temp2
clear 
echo table $tname was created successfully
sleep 2
select choice in "Go to previous menu" "Go to main menu"
do
case $REPLY in
1) table
break
;; 
2) main
break
;;
*) echo $REPLY is not one of the choices.
;;
esac
done
 

};









function edittable 
{
clear 
printf '\t\t\t\t *---Database Engine---*\t\t\t\t ';

 select choice in insert  modify display delete
do
case $REPLY in
1)  insert $1 $2
;; 
2) update $1 $2

;;
3) display $1 $2

;; 
4) delete $1 $2 

;;

*) echo $REPLY is not one of the choices.

;;
esac
done 




};




function table

{
clear 
printf '\t\t\t\t *---Database Engine---*\t\t\t\t ';
echo "Editing  $1 database" ;
printf "______________________\n\n"


select choice in "create a new table" "edit existing table" "delete Database $1"
do
case $REPLY in
1) createtable $1
;;
2) showtables $1 
;;
3)
rm -r ./dbengine/databases/$1
rm -r ./dbengine/metadata/$1
clear 
 echo database $1 was deleted successfully
sleep 2 
main 

;;
*) echo $REPLY is not one of the choices.

;;
esac
done







}

function makedb {

echo "please enter Database name :"
read dbname 

while true
do
if [ ! -d dbengine/databases/$dbname ] 
then 
mkdir  dbengine/databases/$dbname
mkdir  dbengine/metadata/$dbname
 echo database created successfully
sleep 1
break
else  
echo sry database already exists please entre a new name 
read dbname

fi  
done
clear 
}

function editdb {
clear 
printf '\t\t\t\t *---Database Engine---*\t\t\t\t ';
echo Type database name from the following to edit :

select choice in `ls ./dbengine/databases`
do


while [ ! -d dbengine/databases/$REPLY ]
do
echo database entered doesnt exist ..try again
sleep 2
editdb

 




done
break
 done 
table  $REPLY



}


function main  {
clear
printf '\t\t\t\t *---Database Engine---*';

PS3=">"
printf "\n \n"
echo "please choose from the following : "
printf "___________________________________\n\n\n";

select choice in "Create Data base" "Edit existing Database" "Exit"
do
case $REPLY in

1)
makedb
clear  
main
break
;;
2) editdb
break

;;
3) exit 0

;;
*) echo $REPLY is not one of the choices
;; 

esac
done
}



main






