# Microherd Lab Auto Start/Stop

This is what I use to automatically start/stop my lab environment every day inside my Harvester node.  I needed something to manage the automatic starting and stopping of my entire lab so I'm not burning electricity all night long.  Feel free to fork and expand for your own personal use if you want.

## Configuration

- Put the .timers and .service files in `/etc/systemd/system`
- Put the .sh files in `/opt`
- `chmod +x /opt/*-lab.sh`
- `systemctl daemon-reload`
- `systemctl enable --now start-lab.timer stop-lab.timer`

## Adjustments if needed

`OnCalendar=*-*-* 00:00:00` in the .timer files is how you can change the time.

      Default is 0600 Central start, with 1800 Central stop.

I named my Rancher vm `rancher`, so you may need to change that too in the .sh files (or comment out that section if you don't need it...or delete it, doesn't really matter)

In the `start-lab.sh`, you may want to change the path for `KUBECONF` too.

```terminal
harvester:/opt # systemctl list-timers start-lab stop-lab
NEXT                        LEFT     LAST                        PASSED    UNIT            ACTIVATES        
Fri 2025-12-19 00:00:00 UTC 7h left  Thu 2025-12-18 15:56:08 UTC 31min ago stop-lab.timer  stop-lab.service
Fri 2025-12-19 12:00:00 UTC 19h left Thu 2025-12-18 15:56:01 UTC 31min ago start-lab.timer start-lab.service

2 timers listed.
Pass --all to see loaded but inactive timers, too.
```
