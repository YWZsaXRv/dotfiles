#!/usr/bin/env bash
# dns: dns cloudflare (1.1.1.1) e ipv6 desativado, via networkmanager
#
# uso: dns.sh [-a] [-r] [-c]
#   -a  aplica o dns cloudflare e desativa o ipv6
#   -r  remove (volta ao dns automatico e reativa o ipv6)
#   -c  confere a configuracao atual
#
# requisitos: networkmanager ativo
#   systemctl is-active NetworkManager
#
# descobrir o nome do perfil e da interface:
#   nmcli connection show      (colunas NAME e DEVICE)
#   ajustar as variaveis "perfil" e "interface" abaixo

perfil="Conexão cabeada 1"
interface="enp3s0"

mostrar_uso() {
    echo "uso: dns.sh [-a] [-r] [-c]"
    echo "  -a  aplica o dns cloudflare e desativa o ipv6"
    echo "  -r  remove (volta ao dns automatico e reativa o ipv6)"
    echo "  -c  confere a configuracao atual"
}

case "$1" in
    -a)
        nmcli connection modify "$perfil" ipv4.dns "1.1.1.1 1.0.0.1" ipv4.ignore-auto-dns yes
        nmcli connection modify "$perfil" ipv6.method disabled ipv6.dns "" ipv6.ignore-auto-dns no
        nmcli connection up "$perfil"
        ;;
    -r)
        nmcli connection modify "$perfil" ipv4.dns "" ipv4.ignore-auto-dns no ipv6.method auto
        nmcli connection up "$perfil"
        ;;
    -c)
        nmcli -f ipv4.dns,ipv4.ignore-auto-dns,ipv6.method connection show "$perfil"
        nmcli device show "$interface" | grep DNS
        getent hosts archlinux.org
        ;;
    "")
        mostrar_uso
        ;;
    *)
        mostrar_uso >&2
        exit 1
        ;;
esac
