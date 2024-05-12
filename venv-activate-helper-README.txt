Add this blob of code to ~/.bashrc
for the venv activation script to work if needed

############
if [ -f "$MORE_STARTUP" ]; then
    . $MORE_STARTUP
elif [ -n "$MORE_STARTUP" ]; then
    echo "Warning! Could not run ${MORE_STARTUP}"
fi
###########

source: https://superuser.com/questions/1701789/how-can-i-have-a-terminal-window-persist-beyond-the-script-it-was-opened-for-n

