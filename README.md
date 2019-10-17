# pisponder
(Pi + Responder)

Run Responder locally on a Raspberry Pi Zero. Just like a LAN Turtle found here:
https://room362.com/post/2016/snagging-creds-from-locked-machines/



pisponder is my first script. All it does is turn a Pi Zero running Raspbian lite into a NTLMv2 hash stealing machine (even when the target computer is locked!).

**Instructions**

Download pisponder.sh, make it executable and then run as root.

Like this for example:
```
wget https://raw.githubusercontent.com/yun14u/pisponder/master/pisponder.sh

sudo chmod 755 pisponder.sh

sudo ./pisponder.sh
```

This script will work on any Raspberry Pi that has a Ethernet connector (Model B).  Additional requirements are,
* An Ethernet crossover cable
* An USB to micro-USB cable (to provide power to the Pi).

**Credit goes to: **

https://github.com/lgandx/Responder

Mubix from room362.com

https://th3s3cr3tag3nt.blogspot.com/

http://elevatedprompt.com/2016/09/snagging-credentials-from-locked-machines-with-raspberry-pi-zero/
