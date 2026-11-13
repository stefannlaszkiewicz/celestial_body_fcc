#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=salon -t -c"

MAIN_MENU() {
  SERVICES="$($PSQL "SELECT service_id, name FROM services")"

  #Print header if MAIN_MENU was called without an argument
  if [[ -z $1 ]]
  then
    echo -e "\n~~~ Salon Manager ~~~\n"
    echo -e "Which service You want to book?\n"
  else
    echo -e $1
  fi

  echo "$SERVICES" | while read SERVICE_ID BAR SERVICE_NAME
  do
    echo "$SERVICE_ID) $SERVICE_NAME"
  done

  #wait for input
  read SERVICE_ID_SELECTED
  
  #check if SERVICE_ID_SELECTED is a number
  if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]
  then
    #if it's not a number, send to main menu
    MAIN_MENU "\nPlease correct service id"
  else
    #if it is, check if such service_id exists
    INPUT_SERVICE_NAME="$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")"
    if [[ -z $INPUT_SERVICE_NAME ]]
    then
      #if it doesn't, send to main menu
      MAIN_MENU "\nPlease correct service id"
    fi
    #if we are here, then INPU_SERVICE_NAME is ok. proceed

    #ask for phone number
    echo -e "\nWhat's your phone number?"
    read CUSTOMER_PHONE

    #check if customer with that phone number already exists
    CUSTOMER_NAME="$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")"
    if [[ -z $CUSTOMER_NAME ]]
    then
      #if not, ask for name
      echo "What's your name?"
      read CUSTOMER_NAME
      #enter it into db
      INSERT_NEW_CUSTOMER="$($PSQL "INSERT INTO customers (phone, name) VALUES ('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")"
    fi

    #ask for time
    echo "What's the time of the visit?"
    read SERVICE_TIME

    #input entry into appointments
    #first, get the customer id from phone
    CUSTOMER_ID="$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")"

    APPOINTMENT_INPUT="$($PSQL "INSERT INTO appointments (customer_id, service_id, time) VALUES ($CUSTOMER_ID, '$SERVICE_ID_SELECTED', '$SERVICE_TIME')")"

    #print final message. We need servicename first
    SERVICE_NAME="$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")"
    echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
  fi
}

MAIN_MENU