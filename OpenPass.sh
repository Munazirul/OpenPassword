#!/bin/bash
if [[ `command -v openssl` ]]; then
    echo ""
else
    echo "Required packages are not installed, installing it for you..."
    apt-get install openssl -y >/dev/null 2>&1
fi

function banner(){
echo "############################################################################"
echo "#                                                                          #"
echo "#    ___       ____        _____      _____ _____          ___          _  #"
echo "#   / _ \     |___ \      |  __ \    | ____| ____|        / _ \        | | #"
echo "#  | | | |_ __  __) |_ __ | |__) |_ _| |__ | |____      _| | | |_ __ __| | #"
echo "#  | | | | '_ \|__ <| '_ \|  ___/ _  |__  \|___ \ \ /\ / / | | | '__/ _| | #"
echo "#  | |_| | |_) |__) | | | | |  | (_| |___) |___) \ V  V /| |_| | | | (_| | #"
echo "#   \___/| .__/____/|_| |_|_|   \__,_|____/|____/ \_/\_/  \___/|_|  \__,_| #"
echo "#        | |                                                               #"
echo "#        |_|                                                          v1.5 #"
echo "#  Developed by Munazir                                                    #"
echo "#  github: github.com/Munazirul/OpenPassword                               #"
echo "############################################################################"
echo ""
}
trap "echo  ;echo  ;echo [+] Thank you for using OpenPassword;echo Follow me on github: https://github.com/Munazirul;sleep 2;exit 0" 2 5 10
# function hashing(){
#     file1=$(cat .master)
#     pass1=$(echo "$file1" | md5sum > newmaster.txt)

#     file2=$(cat newmaster.txt)
#     pass2=$()
#     if [[ $MASTERPASS_1 == $file2 ]]; then
        
#     fi
# }


function show_pass(){
    echo -e "-> Do you want to view or store a new password (VIEW/STORE):\c"
    read choice
    if [[ $choice == 'VIEW' || $choice == 'view' ]];
    then
    echo -e "-> Specify your service name:\c"
    read choice1
if [[ ! -z choice1  ]]; then
    YOURPASSWORD=$(cat ".$choice1" | openssl enc -aes-128-cbc -a -d -pbkdf2 -pass pass:$MASTERPASS_1)
    # PASSWORD=$(cat $YOURPASSWORD)
    printf "\n-> Your Password is: $YOURPASSWORD\n"
    sleep 3
    show_pass
fi
    elif [[ $choice == 'STORE' || $choice == 'store' ]];
        then
    echo "-> Specify the service for which you want to store your password(e.g: Instagram):"
    read SERVICE
    # echo "$SERVICE" >> stored.txt
    ask_generate
    else
    echo "" ;echo "" ;echo "[+] Thank you for using OpenPassword";echo "Follow me on github: https://github.com/Munazirul";sleep 2;exit 0
    fi
    # show_pass   
}
function generate(){
    GENERATED=$(</dev/urandom tr -dc 'A-Za-z0-9@#$%^&*/_+=' | head -c 14)
    echo "$GENERATED" | openssl enc -aes-128-cbc -pbkdf2 -pass pass:$MASTERPASS_1 -a -out .$SERVICE
    echo "$SERVICE" >> stored.txt
    sleep 2
    echo "-> Your Passsword has been successfully generated and stored securely!"
    generate_store
}

function store_pass(){
    echo "-> Enter your password to be stored for $SERVICE:"
    read -s CURRENTPASS
    echo "$CURRENTPASS" | openssl enc -aes-128-cbc -pbkdf2 -pass pass:$MASTERPASS_1 -a -out .$SERVICE
    echo "$SERVICE" >> stored.txt
    sleep 2
    echo "-> Your password has been stored successfully!"
    generate_store
}
function ask_generate(){
        echo "-> Do you want to generate a new password for $SERVICE or store the current Password(GENERATE/CURRENT): "
        read GENEW
        if [[ $GENEW == 'generate' || $GENEW == 'GENERATE' ]]
        then
        generate
        elif [[ $GENEW == 'CURRENT' || $GENEW == 'current' ]]
        then
        store_pass
        else
        echo "-> Input Invalid!"
        ask_generate
        fi
}
function generate_store(){
 if [[ ! -e stored.txt ]]; then
    printf "\n-> You don't have any password stored yet. Do you want to store new password? (Y/N) "
    read yn
    if [[ $yn == 'y' || $yn == 'Y' ]]
    then
    echo "-> Specify the service for which you want to store your password(e.g: Instagram):"
    read SERVICE
    ask_generate
    else
    # generate_store
    printf "\n Thank you for using OpenPassword"
    printf "\n Follow me on github: https://github.com/Munazirul"
    sleep 5
    exit 0
    fi
 else
 clear
 banner
 echo "-> Your passwords in the database are listed below"
 echo "##########"
 cat stored.txt
 echo "##########"
 show_pass
 fi
}
function validate_masterpassword(){
   # DECRYPTED=$(openssl enc -aes-128-cbc -a -d -pbkdf2 -pass pass:$(cat .key) -in .master -out tmp.txt)
   HASHED=$(echo "$MASTERPASS_1" | md5sum | cut -d " " -f 1)
   # DECRYPTED1=$(cat $HASHED)
   MASTER=$(cat .master | cut -d " " -f 1)
if [ $HASHED == $MASTER ]
then
    # rm -rf tmp.txt
 generate_store
else 
echo "-> Wrong Master password!"
create_password
fi
}
banner
#create_password
function start_master_password(){
echo -e "-> Enter your Master Password:"
read -s MASTERPASS_1
validate_masterpassword
}

function create_password(){
if [ ! -f .master ]; then
    printf "\n-> Create a new Mater Password for the OpenPassword:"
    read -s MASTERPASS
    printf "\n-> Confirm your Password:"
    read -s CONFIRM_MASTERPASS
    # printf "\n->Enter a secret key:"
    # read -s SECRETKEY
if [ $MASTERPASS ==  $CONFIRM_MASTERPASS ];
then 
    # echo "$SECRETKEY" > .key
    # echo "$MASTERPASS" | openssl enc -aes-128-cbc -pbkdf2 -pass pass:$SECRETKEY -a -out .master
    echo "$MASTERPASS" | md5sum | cut -d " " -f 1 > .master
    echo ""
    echo ""
    echo "-> Password created successfully!"
    sleep 2
    # echo "Run this script again to login!"
    # exit 0
    clear
    banner
    create_password
else 
    printf "\n\n Wrong Master Password!"
    create_password
fi
else 
start_master_password
fi
}
create_password

# DECRYPTED=$(openssl enc -aes-128-cbc -a -d -pbkdf2 -pass pass:$(cat .key) -in .master -out tmp.txt)
# if [ $MASTERPASS_1 == $DECRYPTED ]
# then
