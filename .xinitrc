# Set the background image with feh
feh --bg-scale ~/.local/share/bg.jpg  # or your correct background path
# Run the monitor setup script if you have custom monitor arrangements
~/setup-monitors.sh
# Start picom for transparency
picom -b
# Launch dbus session for compatibility with certain apps
eval "$(dbus-launch --sh-syntax --exit-with-session)"
# Start dwm
exec dwm

