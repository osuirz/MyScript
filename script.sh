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
options(){
    output "Selecione uma opção:"
    output "[1] Abrir todas as portas."
    output "[2] Limpar historico."
    read choice
    case $choice in
        1 ) installoption=1
            output "Você selecionou abrir as portas da Maquina."
            ;;
        2 ) installoption=2
            output "Você selecionou limpar o historico da Maquina."
            ;;   
            * ) output "Você não selecionou uma opção valida."
            install_options
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

            
