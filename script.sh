# Starting
output(){
    echo -e '\e[36m'$1'\e[0m';
}

warn(){
    echo -e '\e[31m'$1'\e[0m';
}
preflight(){

output "==================="
output ""
output "Script criado por KoddyDev"
output ""
output "==================="
    os_check

    if [ "$EUID" -ne 0 ]; then
        output "Please run as root."
        exit 3
    fi
}
os_check(){
    if [ -r /etc/os-release ]; then
        lsb_dist="$(. /etc/os-release && echo "$ID")"
        dist_version="$(. /etc/os-release && echo "$VERSION_ID")"
        if [ $lsb_dist = "rhel" ]; then
            dist_version="$(echo $dist_version | awk -F. '{print $1}')"
        fi
    else
        exit 1
    fi
    
    if [ "$lsb_dist" =  "ubuntu" ]; then
        if  [ "$dist_version" != "20.04" ] && [ "$dist_version" != "18.04" ]; then
            output "Unsupported Ubuntu version. Only Ubuntu 20.04 and 18.04 are supported."
            exit 2
        fi
    elif [ "$lsb_dist" = "debian" ]; then
        if [ "$dist_version" != "10" ]; then
            output "Unsupported Debian version. Only Debian 10 is supported."
            exit 2
        fi
    elif [ "$lsb_dist" = "fedora" ]; then
        if [ "$dist_version" != "33" ] && [ "$dist_version" != "32" ]; then
            output "Unsupported Fedora version. Only Fedora 33 and 32 are supported."
            exit 2
        fi
    elif [ "$lsb_dist" = "centos" ]; then
        if [ "$dist_version" != "8" ]; then
            output "Unsupported CentOS version. Only CentOS Stream and 8 are supported."
            exit 2
        fi
    elif [ "$lsb_dist" = "rhel" ]; then
        if  [ $dist_version != "8" ]; then
            output "Unsupported RHEL version. Only RHEL 8 is supported."
            exit 2
        fi
    elif [ "$lsb_dist" != "ubuntu" ] && [ "$lsb_dist" != "debian" ] && [ "$lsb_dist" != "centos" ]; then
        output "Unsupported operating system."
        output ""
        output "Supported OS:"
        output "Ubuntu: 20.04, 18.04"
        output "Debian: 10"
        output "Fedora: 33, 32"
        output "CentOS: 8, 7"
        output "RHEL: 8"
        exit 2
    fi
}
install_options(){
    output "Please select your installation option:"
    output "[1] Liberar todas as portas."
    output "[2] Limpar historico da maquina."
    read choice
    case $choice in
        1 ) installoption=1
            output "You have selected ${PANEL} panel installation only."
            ;;
        2 ) installoption=2
            output "You have selected ${PANEL_LEGACY} panel installation only."
            ;;
        * ) output "You did not enter a valid selection."
            install_options
    esac
}
            #Execucion
preflight
install_options
case $installoption in 
        1)  iptables -A INPUT -s 127.0.0.1 -j ACCEPT
            iptables -A OUTPUT -s 127.0.0.1 -j ACCEPT
            output "As portas foram abertas com sucesso!"
            ;;
        2) history -c
           output "O historico da maquina foi limpo com sucesso.
           ;;

            
