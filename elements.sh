#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ $1 != '' ]]
then
  if [[ $1 =~ ^[0-9]+$ ]]
  then
  ELE=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius
        FROM elements LEFT JOIN properties USING (atomic_number) LEFT JOIN types USING (type_id) 
        WHERE atomic_number=$1")
  else
  ELE=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius
        FROM elements LEFT JOIN properties USING (atomic_number) LEFT JOIN types USING (type_id) 
        WHERE symbol='$1' OR name='$1'")
  fi
  if [[ -z $ELE ]]
  then
    echo "I could not find that element in the database."
  else
    echo $ELE | while IFS="|" read A_N NAME SYMBOL TYPE A_M MP BP
    do
    echo "The element with atomic number $A_N is $NAME ($SYMBOL). It's a $TYPE, with a mass of $A_M amu. $NAME has a melting point of $MP celsius and a boiling point of $BP celsius."
    done
  fi
else
  echo Please provide an element as an argument.
fi



