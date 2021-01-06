#!/bin/bash

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

output "==================="
output ""
output ""
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
            output "Script suporta apenas Ubuntu 20.04 e 18.04."
            exit 2
        fi
    elif [ "$lsb_dist" = "debian" ]; then
        if [ "$dist_version" != "10" ]; then
            output "Script suporta apenas Debian 10."
            exit 2
        fi
    elif [ "$lsb_dist" = "fedora" ]; then
        if [ "$dist_version" != "33" ] && [ "$dist_version" != "32" ]; then
            output "Script suporta apenas Fedora 33 e 32"
            exit 2
        fi
    elif [ "$lsb_dist" = "centos" ]; then
        if [ "$dist_version" != "8" ]; then
            output "Script suporta apenas CentOS 7 e 8"
            exit 2
        fi
    elif [ "$lsb_dist" = "rhel" ]; then
        if  [ $dist_version != "8" ]; then
            output "Script suporta apenas RHEL 8"
            exit 2
        fi
    elif [ "$lsb_dist" != "ubuntu" ] && [ "$lsb_dist" != "debian" ] && [ "$lsb_dist" != "centos" ]; then
        output "Sistema não suportado."
        output ""
        output "Versões suportadas:"
        output "Ubuntu: 20.04, 18.04"
        output "Debian: 10"
        output "Fedora: 33, 32"
        output "CentOS: 8, 7"
        output "RHEL: 8"
        exit 2
    fi
}
install_options(){
    output "Selecione uma opção:"
    output "[1] Liberar todas as portas."
    output "[2] Limpar historico da maquina."
    output ""
    read choice
    case $choice in
        1 ) installoption=1
            output "Você selecionou a opção de abrir todas as portas."
            ;;
        2 ) installoption=2
            output "Você selecionou limpar o historico da maquina."
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
            iptables -I INPUT -p tcp -m multiport --dports 25565,25566,25567,25568,25569,25570,25571,25572,25573,25574 -j ACCEPT
            iptables -I INPUT -p tcp -m multiport --dports 25575,25576,25577,25578,25579,25580,25581,25582,25583,25584 -j ACCEPT
            iptables -I INPUT -p tcp -m multiport --dports 25585,25586,25587,25588,25589,25589,25591,25592,25593,25594 -j ACCEPT
            iptables -I INPUT -p tcp -m multiport --dports 25595,25596,25597,25598,25599,25600,25601,25602,25603,25604 -j ACCEPT
            iptables -I INPUT -p tcp -m multiport --dports 25605,25606,25607,25608,25609,25610,25611,25612,25613,25614 -j ACCEPT
            iptables -I INPUT -p tcp -m multiport --dports 25615,25616,25617,25618,25619,25620,25621,25622,25623,25624 -j ACCEPT
            iptables -I INPUT -p tcp -m multiport --dports 25625,25626,25627,25628,25629,25630,25631,25632,25633,25634 -j ACCEPT
            iptables -I OUTPUT -p tcp -m multiport --dports 25565,25566,25567,25568,25569,25570,25571,25572,25573,25574 -j ACCEPT
            iptables -I OUTPUT -p tcp -m multiport --dports 25575,25576,25577,25578,25579,25580,25581,25582,25583,25584 -j ACCEPT
            iptables -I OUTPUT -p tcp -m multiport --dports 25585,25586,25587,25588,25589,25589,25591,25592,25593,25594 -j ACCEPT
            iptables -I OUTPUT -p tcp -m multiport --dports 25595,25596,25597,25598,25599,25600,25601,25602,25603,25604 -j ACCEPT
            iptables -I OUTPUT -p tcp -m multiport --dports 25605,25606,25607,25608,25609,25610,25611,25612,25613,25614 -j ACCEPT
            iptables -I OUTPUT -p tcp -m multiport --dports 25615,25616,25617,25618,25619,25620,25621,25622,25623,25624 -j ACCEPT
            iptables -I OUTPUT -p tcp -m multiport --dports 25625,25626,25627,25628,25629,25630,25631,25632,25633,25634 -j ACCEPT        
            output "As portas foram abertas com sucesso!"
            ;;
        2) history -c
           output "O historico da maquina foi limpo com sucesso."
           ;;          
           esac
