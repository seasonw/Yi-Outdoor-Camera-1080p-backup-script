<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
</head>
<body>
<h1>Backup shell script for Yi Outdoor Camera 1080p</h1>
<br>
<h2>Purpose</h2>
I have a chance to work on a Yi Outdoor 1080p Camera, main purpose
is to find out a way to save recorded videos to a larger storage in
order to have more days of video backup. This is because SD card
will be overwritten once storage full, a 64GB SD card can store less
than 7 days video recorded in 1080p.<br>
<img src="https://github.com/seasonw/Yi-Outdoor-Camera-1080p-backup-script/raw/master/wiki/yi_outdoor_camera.jpg" alt="" width="445" height="334"><br>
<br>
<h2>Camera's default feature for storage<br>
</h2>
The only methods to save more videos in the camera's default feature
is:-<br>
<ol>
<li>Increase SD card storage (but we don't know if the camera will
work well on SD card larger than max storage as stated in the
specification - 64GB).</li>
<li>Pay to use Yi Cloud (never try out, but I assumed cloud
storage can be customized with $$$).</li>
</ol>
<p><br>
</p>
<h2>Yi Camera Hack</h2>
<p>I found Yi Camera's firmware can be hacked (<a
href="https://github.com/TheCrypt0/yi-hack-v4">https://github.com/TheCrypt0/yi-hack-v4</a>)
to have more features such as SSH, FTP, RTSP, etc. This is a good
start and I decided to try it out. It is simple, just follow the
instruction and extract 2 firmware files to SD card's root folder
will do.<br>
</p>
<p>At first I was thinking to use RTSP, but it is not too heavy for
backup only solution, therefore FTP is the final choice and meet
the requirement.<br>
</p>
<p><br>
</p>
<h2>Setup</h2>
<p>I need a hard disk for storage and an attached computer to work
as FTP client to download data from the camera. NAS (Network
Attached Storage) is the best solution but I have only one to
backup my data, don't want to mess it up. Therefore, I use a
single computer from my Odroid MC1, which is known as Odroid MC1
Solo - <a href="https://www.hardkernel.com/shop/odroid-mc1-solo/">https://www.hardkernel.com/shop/odroid-mc1-solo/</a>.
It is equipped with 2GB RAM, ethernet port and USB port.<br>
<img src="https://github.com/seasonw/Yi-Outdoor-Camera-1080p-backup-script/raw/master/wiki/odroid_mc1_solo.jpg" alt="" width="445" height="334"><br>
<br>
Hardware:-<br>
</p>
<ul>
<li>Yi Outdoor Camera</li>
<li> Odroid MC1 Solo</li>
<li>External USB hard disk</li>
</ul>
<p>Software:-<br>
</p>
<ul>
<li>Hacked firmware for Yi Outdoor Camera</li>
<li>Odroid MC1 default operating system (Ubuntu 16.04)</li>
</ul>
<p>First of all I formatted hard disk to ext4 because it will be
operating under Ubuntu and the backup script is written in shell
script. Formatted hard disk mounted to folder /mnt/hdd1. There are
2 shell scripts in this repository, core script is backup141.sh,
you can edit the script to change constants to fit your
environment:-<br>
</p>
<ul>
<li>TOTAL_DAYS_KEEP : Total days of video recorded that you wish
to keep in the harddisk, the script will delete old videos
before it started to backup.<br>
</li>
<li>IP_ADDRESS : IP of the camera, I have configured it as fixed
local IP in my router.<br>
</li>
<li>BACKUP_MAINFOLDER : main backup folder in the harddisk<br>
</li>
<li>BACKUP_SUBFOLDER : sub backup folder (it is not require to
change unless Yi Camera change it's default folder)</li>
</ul>
<p>I am using WGET to access to camera's FTP server (* while
preparing this documentation, I just noticed that I hardcoded IP
in the WGET, you may replace it with IP_ADDRESS constant instead).
<br>
</p>
<p>In order to run the script in cron with proper documented log
file with datetime as filename, I created another parent shell
script - backupall.sh. This backupall.sh will run backup141.sh
with proper datetime filename's log file, and it can add more core
scripts for extra camera. Again, you can change the constants for
your needs.<br>
</p>
<p>Command to add to cron:-<br>
</p>
<pre>sudo -s</pre>
<pre>crontab -e</pre>
Then run script every hour:-<br>
<table width="629" height="30" cellspacing="2" cellpadding="2"
border="0">
<tbody>
<tr>
<td bgcolor="#000000"><font color="#ffffff">0 * * * *
/bin/bash -c "/mnt/hdd1/backupall.sh" 2&gt;&amp;1</font></td>
</tr>
</tbody>
</table>
<p><br>
</p>
<h2>License</h2>
<p>This application is developed by Season Wong. It is free software
and licensed under the <a
href="https://www.gnu.org/licenses/gpl-3.0.txt">GNU General
Public License v3.0 (GPLv3)</a>.<br>
</p>
<p><br>
</p>
<br>
</body>
</html>

