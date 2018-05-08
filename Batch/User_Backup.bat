@ECHO OFF
CLS
:: Set Variables Here. Will changes these to interactive prompts eventually within the script.
set src="\\woodk-old\c$\Users\woodk"
set dest="C:\Archive"
:: Begin Loop
:loop
:: Modified RoboCopy, Will probably have to exclude more things in the future. 
:: Because I'm filtering out .DAT files, this will NOT copy user profile data.
robocopy %src% %dest% /MIR /Z /MT:4 /xj /xd "Google Drive" "Links" "Saved Games" "Temporary Internet Files" "Searches" /XF *.tmp *.DAT *.LOG1 *.LOG2 *.LOG /dcopy:DAT /np /v /R:3 /W:2 /LOG:"C:\log.txt"
CLS
ECHO Archiving %src% to %dest%
ECHO Please Wait... 
:: This causes the script to loop if the two destinations aren't in sync completely. This includes incremental changes.
IF NOT %errorlevel% lss 8 goto :loop
:: If the script is able to succeed past this point, it will output with this message and close.
ECHO All Files Backed Up!
ECHO Please Check the log file at C:\Log.txt for additional information.