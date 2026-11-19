#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t -c"
#write a function that retrieves what i need based on atomic number
PRINT_MESSAGE_BASED_ON_ID() {
  ATOMIC_NUMBER=$1
  ##check if an element with this atomic number exists
  ##since I assume the db are synced, I'll check only in elements
  #EXISTENCE_QUERY=$($PSQL "SELECT * FROM elements WHERE atomic_number=$ATOMIC_NUMBER") <-- I can check based on ELEMENT_QUERY (if it's empty or not)
  ELEMENT_QUERY=$($PSQL "SELECT symbol, name FROM elements WHERE atomic_number=$ATOMIC_NUMBER")
  PROPERTIES_QUERY=$($PSQL "SELECT atomic_mass, melting_point_celsius, boiling_point_celsius, type_id FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
  #initalize variables
  if [[ -z $ELEMENT_QUERY || -z $PROPERTIES_QUERY ]]
  #exit function
  then
    echo "I could not find that element in the database."
    return
  fi

  echo $ELEMENT_QUERY | while read SYMBOL BAR NAME
  do
    echo $PROPERTIES_QUERY | while read ATOMIC_MASS BAR MELTING BAR BOILING BAR TYPE_ID
    do
      TYPE_QUERY=$($PSQL "SELECT type FROM types WHERE type_id=$TYPE_ID")
      echo $TYPE_QUERY | while read TYPE
      do
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
      done
    done
  done
}
#so it finishes without args
if [[ -z $1 ]]
#this line is for commiting
then
  echo "Please provide an element as an argument."
else
  #user provided an argument
  #if arguments is a number
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    PRINT_MESSAGE_BASED_ON_ID $1
  else
    #else it's a text
    #convert text to id
    #first start with symbol
    ID=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1'")
    if ! [[ -z $ID ]]
    then
      PRINT_MESSAGE_BASED_ON_ID $ID
    else
      #else its full name
      ID=$($PSQL "SELECT atomic_number FROM elements WHERE name='$1'")
      PRINT_MESSAGE_BASED_ON_ID $ID
    fi
  fi
  #if argument is a text
fi

