#!/bin/bash


# see: https://code.jsoftware.com/wiki/System/Installation/Archived
J701_LINUX_SH=http://www.jsoftware.com/download/j701a_linux64.sh
J602_LINUX_SH=http://www.jsoftware.com/download/j602a_linux64.sh
J801_LINUX_TAR=http://www.jsoftware.com/download/j801/j801_linux64.tar.gz
J802_LINUX_TAR=http://www.jsoftware.com/download/j802/install/j802_linux64.tar.gz
J803_LINUX_TAR=http://www.jsoftware.com/download/j803/install/j803_linux64.tar.gz
J804_LINUX_TAR=http://www.jsoftware.com/download/j804/install/j804_linux64.tar.gz
J805_LINUX_TAR=http://www.jsoftware.com/download/j805/install/j805_linux64.tar.gz
J806_LINUX_TAR=http://www.jsoftware.com/download/j806/install/j806_linux64.tar.gz
J807_LINUX_TAR=http://www.jsoftware.com/download/j807/install/j807_linux64.tar.gz

J901_LINUX_TAR=http://www.jsoftware.com/download/j901/install/j901_linux64.tar.gz
J902_LINUX_TAR=http://www.jsoftware.com/download/j902/install/j902_linux64.tar.gz
J903_LINUX_TAR=http://www.jsoftware.com/download/j903/install/j903_linux64.tar.gz

function get_dl {
  LINK=$( case "$J_VER" in
  602) echo "$J602_LINUX_SH" ;;
  701) echo "$J701_LINUX_SH" ;;
  801) echo "$J801_LINUX_TAR" ;;
  802) echo "$J802_LINUX_TAR" ;;
  803) echo "$J803_LINUX_TAR" ;;
  804) echo "$J804_LINUX_TAR" ;;
  805) echo "$J805_LINUX_TAR" ;;
  806) echo "$J806_LINUX_TAR" ;;
  807) echo "$J807_LINUX_TAR" ;;
  901) echo "$J901_LINUX_TAR" ;;
  902) echo "$J902_LINUX_TAR" ;;
  903) echo "$J903_LINUX_TAR" ;;
  *) echo "" ;;
esac)
}

function create_6 {
  if [ -z $JAVA_HOME ]
  then
    echo "It does not appear Java is installed. Java must be installed.\n";
    exit 1
  fi


  J_DIR="${HOME:?}/j64-${J_VER}"
  J_USER_DIR="${HOME:?}/j64-${J_VER}-user"
  JMAN_DIR="${HOME:?}/.jman/env/j${J_VER}"
  INSTALL_DIR=${HOME:?}  # change
  mkdir -p "$JMAN_DIR" 
  if [ -d "${J_DIR}" ]
  then
    echo "Directory ${J_DIR} exists. No need to install J Version ${J_VER}."
  else
    echo "Downloading ${LINK}!"
    wget --no-clobber ${LINK} -P $JMAN_DIR
    chmod +x $JMAN_DIR/j602a_linux64.sh
    mkdir -p $J_DIR
    /bin/bash $JMAN_DIR/j602a_linux64.sh -install $INSTALL_DIR
    sed -i 's/java64/java/g; s/bin/./g' $J_DIR/bin/jwd # ~~hacky~~!
  fi
  mkdir -p $J_USER_DIR/projects/$PRJ_NAME
  touch $J_USER_DIR/projects/$PRJ_NAME/init.ijS
  echo "Project folder created at ${J_USER_DIR}/projects/${PROJ_NAME}".
}

function create_7 {
  if [ -z $JAVA_HOME ]
  then
    echo "It does not appear Java is installed. Java must be installed.\n";
    exit 1
  fi


  J_DIR="${HOME:?}/j64-${J_VER}"
  J_USER_DIR="${HOME:?}/j64-${J_VER}-user"
  JMAN_DIR="${HOME:?}/.jman/env/j${J_VER}"
  INSTALL_DIR=${HOME:?}  # change
  mkdir -p "$JMAN_DIR" 
  if [ -d "${J_DIR}" ]
  then
    echo "Directory ${J_DIR} exists. No need to install J Version ${J_VER}."
  else
    echo "Downloading ${LINK}!"
    wget --no-clobber ${LINK} -P $JMAN_DIR
    chmod +x $JMAN_DIR/j701a_linux64.sh
    mkdir -p $J_DIR
    /bin/bash $JMAN_DIR/j701a_linux64.sh -install $INSTALL_DIR 
  fi
  mkdir -p $J_USER_DIR/projects/$PRJ_NAME
  touch $J_USER_DIR/projects/$PRJ_NAME/init.ijs
  echo "Project folder created at ${J_USER_DIR}/projects/${PROJ_NAME}".

}

function create_8_or_9 {

  J_DIR="${HOME}/j64-${J_VER}"
  J_USER_DIR="${HOME}/j64-${J_VER}-user"
  JMAN_DIR="$HOME/.jman/env/j${J_VER}"
  mkdir -p "$JMAN_DIR"

  echo "${J_DIR}"
  if [ -d "${J_DIR}" ]
  then
    echo "Directory ${J_DIR} exists. No need to install J Version ${J_VER}."
  else
    echo "Downloading ${LINK}!"
    wget --no-clobber ${LINK} -P $JMAN_DIR
    FILE=${LINK##*/}
    mkdir -p $J_DIR
    tar -C $HOME -xvf "${JMAN_DIR}/${FILE}"
    /bin/bash ${J_DIR}/updatejqt.sh 
  fi
  mkdir -p $J_USER_DIR/projects/$PRJ_NAME
  touch $J_USER_DIR/projects/$PRJ_NAME/init.ijs
  echo "Project folder created at ${J_USER_DIR}/projects/${PROJ_NAME}".
}



if [ $# -lt 2 ] ; then

  echo "Too few arguments."
  exit 1
fi

if [ $# -eq 2 ] ; then
  PRJ_NAME=$1
  J_VER=$2
fi

if [ $EUID -eq 0 ] ; then
  echo "Do not run with sudo privileges."
  exit 1
fi
mkdir -p $HOME/.jman

get_dl
if [ "$LINK" == "" ] ; then
  echo  "Could not find the J version ${J_VER}."
  exit 1
fi

if [ $J_VER == "602" ] ; then
  create_6
elif [ $J_VER == "701" ] ; then
  create_7
else
  create_8_or_9
fi

