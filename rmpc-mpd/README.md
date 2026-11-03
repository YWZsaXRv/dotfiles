## pacotes
sudo pacman -S mpd rmpc mpc
## diretórios
mkdir -p ~/.config/mpd
mkdir -p ~/.config/rmpc
mkdir -p ~/.local/share/mpd/playlists
## ativar mpd
systemctl --user enable --now mpd
## atualizar biblioteca
mpc update
## mpd-mpris [para aparecer no player do noctalia] 
sudo pacman -S mpd-mpris
systemctl --user enable --now mpd-mpris
## atalhos rmpc
Tecla	Função
p	Play/Pause
s	Stop
>	Próxima música
<	Música anterior
.	Aumentar volume
,	Diminuir volume
z	Repeat
x	Random
c	Consume
v	Single
1–7	Trocar abas
?	Ajuda
q	Sair
