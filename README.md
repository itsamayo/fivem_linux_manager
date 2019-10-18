# fivem_linux_manager
## Description
Manage your Fivem Linux server

Includes server script for sending in game message notifications 15 minutes, 10 minutes, 5 minutes, and 30 seconds before restart - default is set for restarts twice a day at 6am and 6pm.

## Setup
* Install into resources directory

* Add the following line to your mods list in server.cfg
```
ensure fivem_linux_manager
```

* Move the `manager.sh` file to your roots /bin/ directory and run the following from your terminal to be able to run commands from the terminal:
```
$ sudo chmod +x /bin/manager.sh
```
## Configuration
* To setup automatic restarts you'll need to edit your systems CRON jobs
* `crontab` is the simplest to use as it comes standard on most linux distributions. You can edit it using your servers default editor with:
```
$ crontab -e
```
* Once in editing mode, add the below to it (this will set auto restart for 6am and 6pm relative to your servers time)
```
0 6 * * * manage.sh restart
0 18 * * * manage.sh restart
```

## Important Notes
* Make sure your FiveM path in your root directory matches what's in `manager.sh` at `FIVEM_PATH=/FiveM` as well as the CRON setting above
* The `stop` and `restart` methods will clear your servers cache found at `resources/cache`, if you don't want to clear your cache you can remove the following lines from the `manage.sh` file for both methods):
```
rm -R $FIVEM_PATH/server-data/cache/
echo -e "$GREEN Clearing the cache. $NORMAL"
```

## Usage
* Once configured you can run `start`, `stop`, `restart`, `status`, `screen` from your servers terminal whenever you like

