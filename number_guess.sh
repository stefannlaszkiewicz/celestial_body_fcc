#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=guessing_game -t -c"
#initalize random number
RANDOM_NUMBER=$((1+$RANDOM%1000))
GUESSES=0
#read username
echo "Enter your username: "
read USERNAME
#check if this username exists in db
USERNAME_QUERY=$($PSQL "SELECT games_played, fewest_guesses FROM players WHERE username='$USERNAME'")
#if empty, insert into db
if [[ -z $USERNAME_QUERY ]]
then
  #insert this user into db
  INSERT_STATUS=$($PSQL "INSERT INTO players (username) VALUES ('$USERNAME')") 
  #repeat the query
  USERNAME_QUERY=$($PSQL "SELECT games_played, fewest_guesses FROM players WHERE username='$USERNAME'")
  echo "Welcome, $USERNAME! It looks like this is your first time here."
else
  #the user has info in db
  echo $USERNAME_QUERY | while read GAMES_PLAYED BAR FEWEST_GUESSES
  do
    echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $FEWEST_GUESSES guesses."
  done
fi

GUESS_GAME() {
  GUESSES=$(($GUESSES+1))

  if [[ -z $1 ]]
  then
    echo "Guess the secret number between 1 and 1000:"
  else
    echo $1
  fi

  read GUESS

  if ! [[ $GUESS =~ ^[0-9]+$ ]]
  then
    GUESS_GAME "That is not an integer, guess again: "
  else
    #begin guessing
    if [[ $GUESS > $RANDOM_NUMBER ]]
    then
     GUESS_GAME "It's lower than that, guess again:"
    elif [[ $GUESS < $RANDOM_NUMBER ]]
    then
      GUESS_GAME "It's higher than that, guess again:"
    else
      #now this goes off exactly once
      echo "You guessed it in $GUESSES tries. The secret number was $RANDOM_NUMBER. Nice job!"
      #update db to +1 games played
      GAMES_PLAYED=$($PSQL "SELECT games_played FROM players WHERE username='$USERNAME'")
      GAMES_UPDATE=$($PSQL "UPDATE players SET games_played=$((GAMES_PLAYED+1)) WHERE username='$USERNAME'")
      #update db if new fewest guesses achieved
      FG=$($PSQL "SELECT fewest_guesses FROM players WHERE username='$USERNAME'")
      if ! [[ $FG =~ [0-9] ]]
      then
        FG_UPDATE=$($PSQL "UPDATE players SET fewest_guesses=$GUESSES WHERE username='$USERNAME'")
      else
        if [[ $GUESSES < $FG ]] 
        then
          FG_UPDATE=$($PSQL "UPDATE players SET fewest_guesses=$GUESSES WHERE username='$USERNAME'")
        fi
      fi

    fi
  fi
}

echo $RANDOM_NUMBER
GUESS_GAME
