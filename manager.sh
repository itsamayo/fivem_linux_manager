#!/bin/bash

# FiveM master path
    FIVEM_PATH=/FiveM

# Servers terminal screen
    SCREEN="fivem"

# Restart message
    RESTART_MESSAGE="Server will restart in 30 seconds"

# Colours for messages
    NORMAL="\033[0;37m"
    RED="\033[1;31m"
    GREEN="\033[1;32m"
    ORANGE="\033[1;33m"

cd $FIVEM_PATH	
running(){
    if ! screen -list | grep -q "$SCREEN"
    then
        return 1
    else
        return 0
    fi
}	

case "$1" in
    # -----------------[ Start ]----------------- #
    start)
	if ( running )
	then
	    echo -e "$RED The server [$SCREEN] is already running $NORMAL"
	else
        echo -e "$ORANGE The server [$SCREEN] will start momentarily $NORMAL"
		screen -dm -S $SCREEN
		sleep 2
		screen -x $SCREEN -X stuff "cd "$FIVEM_PATH"/server-data && bash "$FIVEM_PATH"/run.sh +exec server.cfg"
		echo -e "$ORANGE Restarting the sessions $NORMAL"
		sleep 20
		screen -x $SCREEN -X stuff "restart sessionmanager"
		echo -e "$GREEN Sessions are good to go $NORMAL"
		sleep 5
		echo -e "$GREEN Server is good to go $NORMAL"
	fi
    ;;
    # -----------------[ Stop ]------------------ #
    stop)
	if ( running )
	then
		echo -e "$GREEN Shutting server down in 10 seconds $NORMAL"
        screen -S $SCREEN -p 0 -X stuff "`printf "say $RESTART_MESSAGE\r"`"; sleep 10
		screen -S $SCREEN -X quit
        echo -e "$RED The server [$SCREEN] is shutting down $NORMAL"
		sleep 5
		echo -e "$GREEN Server [$SCREEN] has shut down $NORMAL"
		rm -R $FIVEM_PATH/server-data/cache/
		echo -e "$GREEN Clearing the cache $NORMAL"

	else
	    echo -e "The server [$SCREEN] couldn't be stopped, most likely because it was never up to begin with"
	fi
    ;;
    # ----------------[ Restart ]---------------- #
	restart)
	if ( running )
	then
	    echo -e "$RED The server [$SCREEN] is currently running $NORMAL"
	else
	    echo -e "$GREEN The server [$SCREEN] is off $NORMAL"
	fi
	    echo -e "$RED The server will restart soon $NORMAL"
		screen -S $SCREEN -p 0 -X stuff "`printf "say $RESTART_MESSAGE\r"`"; sleep 30
		screen -S $SCREEN -X quit
		echo -e "$GREEN Server now off $NORMAL"
		rm -R $FIVEM_PATH/server-data/cache/
		echo -e "$GREEN Clearing the cache $NORMAL"
		sleep 2
		echo -e "$ORANGE Server restart in progress $NORMAL"
		sleep 10
        echo -e "$ORANGE Server [$SCREEN] about to start $NORMAL"
		screen -dm -S $SCREEN
		sleep 2
		screen -x $SCREEN -X stuff "cd "$FIVEM_PATH"/server-data && bash "$FIVEM_PATH"/run.sh +exec server.cfg 
		"
		echo -e "$ORANGE Restarting the sessions $NORMAL"
		sleep 20
		screen -x $SCREEN -X stuff "restart sessionmanager
		"
		echo -e "$GREEN Server [$SCREEN] is up and running $NORMAL"
	;;	
    # -----------------[ Status ]---------------- #
	status)
	if ( running )
	then
	    echo -e "$GREEN [$SCREEN] is all systems go $NORMAL"
	else
	    echo -e "$RED [$SCREEN] is currently offline $NORMAL"
	fi
	;;
    # -----------------[ Screen ]---------------- #
    screen)
        echo -e "$GREEN Server screen [$SCREEN]. $NORMAL"
        screen -R $SCREEN
    ;;
	*)
    echo -e "$ORANGE Utilisation:$NORMAL manage.sh {start|stop|status|screen|restart}"
    exit 1
    ;;
esac

exit 0