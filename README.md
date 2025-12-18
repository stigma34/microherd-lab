# Microherd Lab Auto Start/Stop

This is what I use to automatically start/stop my lab environment every day.  I needed something to manage the automatic starting and stopping of my entire lab so I'm not burning electricity all night long.  Feel free to fork and expand for your own personal use if you want.

## Configuration

- Put the .timers and .service files in `/etc/systemd/system`
- Put the .sh files in `/opt`
- `chmod +x /opt/*-lab.sh`
- `systemctl enable --now start-lab.timer stop-lab.timer`

## Adjustments if needed

`OnCalendar=*-*-* 00:00:00` in the .timer files is how you can change the time.

      Default is 0600 Central start, with 1800 Central stop.

I named my Rancher vm `rancher`, so you may need to change that too in the .sh files (or comment out that section if you don't need it...or delete it, doesn't really matter)
