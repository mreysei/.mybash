# mybash

## Configuración

1. Clonar repositorio en tu home (`cd ~`) con el nombre de `.mybash`.
1. Ejecuta el comando `. ~/.mybash/install.sh` para instalar mybash
1. Reinicia la consola o utiliza el comando `r` si estás actualizando el proyecto

## Documentación
Al hacer la instalación se modificará el .zshrc para que se ejecute .mybash en cada inicio de sesión.

Ésta instalación cuenta con lo siguiente:
- Aliases (comando `a` para ver todos los alias)
- ZSH
- Oh My ZSH
- NVM
- Node latest version
- Plugins de ZSH
  - https://github.com/agkozak/zsh-z -> Para saltar entre ficheros
  - https://github.com/marlonrichert/zsh-autocomplete -> Para autocompletar comandos del historico
  - https://github.com/junegunn/fzf -> Para tener un menú seleccionable
- Configuración de git en base a un workspace (carpeta de trabajo)
- Scripts personalizados y utilizados con alias