#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  #insert into teams
  #check if WINNER is a country name or header
  if [[ $WINNER != 'winner' && $OPPONENT != 'opponent' ]]
  then
    #check if WINNER or OPPONENT are in teams already
    WINNER_IS_IN_TEAMS=$($PSQL "SELECT name FROM teams WHERE name='$WINNER'")
    OPPONENT_IS_IN_TEAMS=$($PSQL "SELECT name FROM teams WHERE name='$OPPONENT'")
    #if it's empty (no entry in db) then add one
    if [[ -z $WINNER_IS_IN_TEAMS ]]
    then
      #insert WINNER INTO db
      WINNER_INSERT_RESPONSE=$($PSQL "INSERT INTO teams(name) VALUES ('$WINNER')")
      echo "$WINNER inserted into teams!"
    fi
    if [[ -z $OPPONENT_IS_IN_TEAMS ]]
    then
      #insert OPPONENT INTO db
      OPPONENT_INSERT_RESPONSE=$($PSQL "INSERT INTO teams(name) VALUES ('$OPPONENT')")
      echo "$OPPONENT inserted into teams!"
    fi
  fi
  #insert into games
  if [[ $YEAR != 'year' ]]
  then
    #get winner and opponent id from teams
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER';")
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT';")
    #check if entry already there (each team_id should clash exactly once)
    IS_IN_DB=$($PSQL "SELECT game_id FROM games WHERE winner_id=$WINNER_ID AND opponent_id=$OPPONENT_ID;")
    #if it's empty then insert
    if [[ -z $IS_IN_DB ]]
    then
      INSERT_RES=$($PSQL "INSERT INTO games(round, winner_id, opponent_id, year, winner_goals, opponent_goals) VALUES('$ROUND', $WINNER_ID, $OPPONENT_ID, $YEAR, $WINNER_GOALS, $OPPONENT_GOALS);")
      echo "match between teams with id's $WINNER_ID and $OPPONENT_ID inserted!"
    fi
  fi
done