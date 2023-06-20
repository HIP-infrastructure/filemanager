SETTINGS_PATH=.config/pcmanfm-qt/default
SETTINGS_FILE=settings.conf
SETTINGS=$SETTINGS_PATH/$SETTINGS_FILE

#avoid execution at ghostfs mount
if [ -L ${SETTINGS_PATH%/*} ] && [ -d ${SETTINGS_PATH%/*} ]
then
  if [ ! -f $SETTINGS ]
  then
    mkdir -p $SETTINGS_PATH
    cat /apps/filemanager/config/$SETTINGS_FILE > $SETTINGS
  fi

  if ! grep -q ^HiddenPlaces $SETTINGS
  then
    sed -i "/^\[Places\].*/a HiddenPlaces=computer:///, $HOME/Desktop, network:///, menu://applications/" $SETTINGS
  fi 
fi

# Load the default .profile
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile"
