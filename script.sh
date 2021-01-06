# Starting

preflight(){

output "==================="
output ""
output "Script criado por KoddyDev"
output ""
output "==================="

    if [ "$EUID" -ne 0 ]; then
        output "Execute com root."
        exit 3
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

            
