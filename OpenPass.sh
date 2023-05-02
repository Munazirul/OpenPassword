#!/bin/bash
clear
if [[ `command -v termux-setup-storage` ]]; then
    if [[ `command -v openssl` ]]; then
        echo ""
    else
        echo "Required packages are not installed, installing it for you..."
        pkg install openssl -y
    fi
elif [[ `command -v openssl` ]]; then
    echo ""
else
    echo "Required packages are not installed, installing it for you..."
    apt-get install openssl -y >/dev/null 2>&1
fi


READHOSTNAME=$(hostname)
    SETHOSTNAME=$READHOSTNAME
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
echo "#        |_|                                                          v2.5 #"
echo "#  Developed by Munazir                           web: https://munazir.com #"
echo "#  github: https://github.com/Munazirul/OpenPassword                       #"
echo "############################################################################"
echo ""
}
trap "echo  ;echo  ;echo [+] Thank you for using OpenPassword;sleep 2;clear;exit 0" 2 5 10
# function hashing(){
#     file1=$(cat .master)
#     pass1=$(echo "$file1" | md5sum > newmaster.txt)

#     file2=$(cat newmaster.txt)
#     pass2=$()
#     if [[ $MASTERPASS_1 == $file2 ]]; then
        
#     fi
# }

function update_pass(){

    printf "\n-> Do you want to generate a new password for $SERVICE1 or store the current Password(GENERATE/CURRENT)\n"
        read -p "$SETHOSTNAME@OpenPassword~$" -r GENEW1
        if [[ $GENEW1 == 'generate' || $GENEW1 == 'GENERATE' ]]
        then
        # GENERATED=$(</dev/urandom tr -dc 'A-Za-z0-9@#$%^&*/_+=' | head -c 14)
        GENERATED=$(</dev/urandom tr -dc 'A-Z0-9@#$^&*_+=a-z' | head -c 14)
        echo "$GENERATED" | openssl enc -aes-128-cbc -pbkdf2 -pass pass:$MASTERPASS_1 -a -out .$SERVICE1
        sleep 2
        echo "-> Your Passsword has been successfully generated and stored securely!"
        sleep 2
        generate_store
        elif [[ $GENEW1 == 'CURRENT' || $GENEW1 == 'current' ]]
        then
        printf "\n-> Enter your password to be stored for $SERVICE1\n"
        read -p "$SETHOSTNAME@OpenPassword~$" -r -s CURRENTPASS
        echo "" 
        echo ""
        h="$(echo -n $CURRENTPASS | sha1sum | cut -d' ' -f1)" 
        echo ""
        echo "Checking online for password breach...."
        echo ""
        sleep 2
        echo "SHA1: $h"; s="${h:0:5}" 
        u="https://api.pwnedpasswords.com/range/$s"
        echo "HTTP GET $u" 
        r=$(curl -s "$u")
        c=0
        for l in $r
        do t="$(echo "${s}${l%:*}" | tr 'A-Z' 'a-z')"
        test "$t" == "$h" && c="$(echo ${l##*:} | tr -d "[:cntrl:]")"
        done
         if [[ c -gt 0 ]]; then
             echo "Your password has been pwned $c time(s)"
         echo ""
         echo "Change your password immediately!!"
         echo ""
         notify-send "OpenPassword" "We have found your password online, Change it immediately"
         echo "Saving..."
        sleep 2
         fi
        echo "$CURRENTPASS" | openssl enc -aes-128-cbc -pbkdf2 -pass pass:$MASTERPASS_1 -a -out .$SERVICE1
        sleep 2
        echo "-> Your password has been stored successfully!"
	sleep 7
        generate_store
        else
        echo "-> Input Invalid!"
        update_pass
        fi
}

# function delete_pass(){
#         echo "-> Do you want to generate a new password for $SERVICE2 or store the current Password(GENERATE/CURRENT): "
#         read GENEW2
#         if [[ $GENEW2 == 'generate' || $GENEW2 == 'GENERATE' ]]
#         then
#         generate
#         elif [[ $GENEW2 == 'CURRENT' || $GENEW2 == 'current' ]]
#         then
#         store_pass
#         else
#         echo "-> Input Invalid!"
#         update_pass
#         fi
# }
function ssmtp_write(){
    echo "UseSTARTTLS=YES
UserTLS=YES
hostname=localhost
root=postmaster
mailhub=smtp.gmail.com:587
AuthUser=$mail_user
AuthPass=$mail_password
TLS_CA_FILE=/etc/ssl/certs/ca-certificates.crt
FromLineOverride=YES" > /etc/ssmtp/ssmtp.conf
}
#configure ssmtp
function ssmtp_conf(){
    if [[ `command -v ssmtp` && `command -v mpack` ]];
        then 
            ssmtp_write
            else 
            echo "->Required packages are not installed. Installing it for you."
            sleep 1
            sudo apt-get -y install ssmtp -y >/dev/null 2>&1 && apt-get install mpack -y >/dev/null 2>&1
            printf "\n\n->Required packages are Installed\n\n"
            sleep 2
            ssmtp_write
            fi
}
function show_pass(){
    printf "\n-> (VIEW/STORE/UPDATE/DELETE/CLEAR/BACKUP)\n"
    read -p "$SETHOSTNAME@OpenPassword~$" -r choice
    if [[ $choice == 'VIEW' || $choice == 'view' ]];
    then
    printf "\n-> Specify your account name\n"
    read -p "$SETHOSTNAME@OpenPassword~$" -r choice1
if [[ ! -z choice1  ]]; then
    YOURPASSWORD=$(cat ".$choice1" | openssl enc -aes-128-cbc -a -d -pbkdf2 -pass pass:$MASTERPASS_1)
    # PASSWORD=$(cat $YOURPASSWORD)
    printf "\n-> Your Password is: $YOURPASSWORD \n"
    sleep 3
    show_pass
fi
    elif [[ $choice == 'STORE' || $choice == 'store' ]];
        then
    printf "\n-> Specify the account for which you want to store your password(e.g: Instagram)\n"
    read -p "$SETHOSTNAME@OpenPassword~$" -r SERVICE
    # echo "$SERVICE" >> stored.txt
    ask_generate
    elif [[ $choice == 'UPDATE' || $choice == 'update' ]]; then
        printf "\n-> Specify the account for which you want to update your Password\n"
        read -p "$SETHOSTNAME@OpenPassword~$" -r SERVICE1
        rm -rf .$SERVICE1
        # sed /^$SERVICE$/d stored.txt > stored.txt
        update_pass
        echo "Your password has been updated for $SERVICE1"
        sleep 2
    elif [[ $choice == 'DELETE' || $choice == 'delete' ]]; then
        printf "\n-> Specify the account for which you want to delete your Password\n"
        read -p "$SETHOSTNAME@OpenPassword~$" -r SERVICE2
        rm -rf .$SERVICE2
        sed -i "/$SERVICE2/d" stored.txt 
        echo "Your password has been deleted for $SERVICE2"
        sleep 2
        generate_store
	elif [[ $choice == 'BACKUP' || $choice == 'backup' ]]; then
        echo "->Before using this feature, goto accounts.google.com > security > 
singning in to google > enable (2-step verification + App Password(note down the password)) 
and enter your gmail and App Password below"
        echo -e "->Enter your gmail address:\c"
        read mail_user
        echo -e "->Enter your App Password:\c"
        read -s mail_password
        ssmtp_conf
        sleep 1
        #BACKUPFILE=$(zip "OpenPassword-"`date +"%d%m%Y%H%M%S"`"" .* -x .master >/dev/null 2>&1) 
        zip "OpenPassword-"`date +"%d%m%Y%H%M%S"`"" .* -x .master >/dev/null 2>&1
        mail_date=$(date +"%d-%b-%Y %H:%M:%S")
        mpack -s "OpenPassword: Password backup created on $mail_date" OpenPassword-*.zip $mail_user
        rm -rf OpenPassword-*.zip
        printf "\n\n->Backupfile has been mailed to you successfully\n\n"
        sleep 2
        generate_store
    elif [[ $choice == 'clear' || $choice == 'CLEAR' ]]; then
       clear
        generate_store
    else
    echo "" ;echo "" ;echo "[+] Thank you for using OpenPassword";sleep 2;clear;exit 0
    fi
    # show_pass   
}
function generate(){
    # GENERATED=$(</dev/urandom tr -dc 'A-Za-z0-9@#$%^&*/_+=' | head -c 14)
    GENERATED=$(</dev/urandom tr -dc 'A-Z0-9@#$^&*_+=a-z' | head -c 14)
    echo "$GENERATED" | openssl enc -aes-128-cbc -pbkdf2 -pass pass:$MASTERPASS_1 -a -out .$SERVICE
    echo "$SERVICE" >> stored.txt
    sleep 2
    echo "-> Your Passsword has been successfully generated and stored securely!"
    generate_store
}

function store_pass(){
    printf "\n-> Enter your password to be stored for $SERVICE \n"
    read -p "$SETHOSTNAME@OpenPassword~$" -r -s CURRENTPASS
    echo "" 
        echo ""
        h="$(echo -n $CURRENTPASS | sha1sum | cut -d' ' -f1)" 
        echo ""
        echo "Checking online for password breach...."
        echo ""
        sleep 2
        echo "SHA1: $h"; s="${h:0:5}" 
        u="https://api.pwnedpasswords.com/range/$s"
        echo "HTTP GET $u" 
        r=$(curl -s "$u")
        c=0
        for l in $r
        do t="$(echo "${s}${l%:*}" | tr 'A-Z' 'a-z')"
        test "$t" == "$h" && c="$(echo ${l##*:} | tr -d "[:cntrl:]")"
        done
       if [[ c -gt 0 ]]; then
             echo "Your password has been pwned $c time(s)"
         echo ""
         echo "Change your password immediately!!"
         echo ""
         notify-send "OpenPassword" "We have found your password online, Change it immediately"
         echo "Saving..."
        sleep 2
         fi
    echo "$CURRENTPASS" | openssl enc -aes-128-cbc -pbkdf2 -pass pass:$MASTERPASS_1 -a -out .$SERVICE
    echo "$SERVICE" >> stored.txt
    sleep 2
    echo "-> Your password has been stored successfully!"
    generate_store
}
function ask_generate(){
        printf "\n-> Do you want to generate a new password for $SERVICE or store the current Password(GENERATE/CURRENT)\n "
        read -p "$SETHOSTNAME@OpenPassword~$" -r GENEW
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
    printf "\n-> You don't have any password stored yet. Do you want to store new password? (Y/N)\n"
    read -p "$SETHOSTNAME@OpenPassword~$" -r yn
    if [[ $yn == 'y' || $yn == 'Y' ]]
    then
    printf "\n-> Specify the service for which you want to store your password(e.g: Instagram)\n"
    read -p "$SETHOSTNAME@OpenPassword~$" -r SERVICE
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
# function check_online(){
#      B=$(cat spc)
#      h="$(echo -n $B | sha1sum | cut -d' ' -f1)"
#         echo ""
#         echo "Checking online for password breach.... Please wait!" >/dev/null 2>&1
#         echo ""
#         # sleep 2
#         echo "SHA1: $h" >/dev/null 2>&1; s="${h:0:5}" >/dev/null 2>&1
#         u="https://api.pwnedpasswords.com/range/$s"  >/dev/null 2>&1
#         echo "HTTP GET $u" >/dev/null 2>&1
#         r=$(curl -s "$u")
#         c=0
#         for l in $r
#         do t="$(echo "${s}${l%:*}" | tr 'A-Z' 'a-z')"
#         test "$t" == "$h" && c="$(echo ${l##*:} | tr -d "[:cntrl:]")"
#         done
#         if [[ c -gt 0 ]]; then
#              # echo "Your password has been pwned $c time(s)" >/dev/null 2>&1
#              echo ""
#         notify-send "OpenPassword" "Some of you passwords have been compramised, Change your passwords immediately" 
#         rm -rf spc
#     else
#         # elif [[ c == 0 ]]; then
#             #statements
#      generate_store1
#      fi
     
# }
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
PASSHINT=$(cat .hint)
echo "HINT: $PASSHINT"
create_password
fi
}
banner
#create_password
function start_master_password(){
printf "\n-> Enter your Master Password\n"
read -p "$SETHOSTNAME@OpenPassword~$" -r -s MASTERPASS_1
validate_masterpassword
}

function create_password(){
if [ ! -f .master ]; then
    READHOSTNAME=$(hostname)
    SETHOSTNAME=$READHOSTNAME
    printf "\n// Welcome to OpenPassword, This tool is designed for general purpose.    //\n// You can store your passwords of various Online accounts.               //\n"
    printf "// Remember, If you forget your Master password, There is no way you      //\n"
    printf "// can recover it. So, Take a backup of your Master password or create a  //\n// Password hint.                                                         //\n"
    printf "\n-> Enter a new Mater Password for the OpenPassword\n"
    read -p "$SETHOSTNAME@OpenPassword~$" -r -s MASTERPASS
    # read -s -r MASTERPASS
    printf "\n\n-> Confirm your Password\n"
    read -p "$SETHOSTNAME@OpenPassword~$" -r -s CONFIRM_MASTERPASS
    printf "\n\n-> Create a password HINT\n"
    read -p "$SETHOSTNAME@OpenPassword~$" -r HINT
if [ $MASTERPASS ==  $CONFIRM_MASTERPASS ];
then 
    echo "$HINT" > .hint
    #echo "$MASTERPASS" | openssl enc -aes-128-cbc -pbkdf2 -pass pass:$SECRETKEY -a -out .master
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

