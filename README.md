# mybash

## Configuración

1. Clonar repositorio en tu home (`cd ~`) con el nombre de `.mybash`.
2. En tu home, añade al final de tu `.bashrc`, `.zshrc` o similares:
```
# mreysei/mybash
if [ -f ~/.mybash/.init ]; then
    . ~/.mybash/.init
fi
```
3. En tu home, en tu `.gitconfig`:
```
[include]
	path = ~/.mybash/.gitconfig/.global
```
4. Reinicia la consola o utiliza el comando `r` si estás actualizando el proyecto

## Paquetes a instalar

- Se utiliza zsh y npx
- https://github.com/agkozak/zsh-z -> Para saltar entre ficheros
- https://github.com/marlonrichert/zsh-autocomplete -> Para autocompletar antiguos comandos
- https://github.com/junegunn/fzf -> Para tener un menú seleccionable

## Otras cosas
- Utilizo el tema de zsh llamado "skaro"