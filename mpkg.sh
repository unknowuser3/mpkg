#!/bin/sh

repo="https://api.github.com/repos/unknowuser3/mpkgrepo/contents/"
pacotes="https://raw.githubusercontent.com/unknowuser3/mpkgrepo/main/"

if [ -z "$1" ]; then
    echo "Parametro invalido!"
    echo "mpkg install PACKAGE"
    echo "mpkg list"
    exit 1
fi

if [ "$1" = "list" ]; then
   echo "Pacotes disponiveis para instalar: "
   printf "\e[1;32m" 
   curl -s $repo | jq -r ".[].name"
   printf "\e[0m"
fi

if [ "$1" = "install" ]; then
    curl -s "$pacotes$2" -o "$2"
    echo "Baixando o pacote '$2'..."
    if [ -f "$2" ]; then
	echo "Baixado!"
	chmod 775 "$2" 2>/dev/null
	mv "$2" /bin/
	echo "'$2' Instalado com sucesso!"
    else
	echo "Erro ao tentar baixar!"
	exit
    fi
fi

if [ "$1" = "update" ]; then
    curl -o /dev/null -s $repo
    if [ $? -eq 0 ]; then
        echo "Repositorios atualizados!"
    else
	echo "Nao foi possivel atualizar!"
    fi
fi
