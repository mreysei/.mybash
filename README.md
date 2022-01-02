# mybash

## Configuración

1. Clonar repositorio en tu home (`cd ~`).
1. En tu home, añade al final de tu `.bashrc`, `.zshrc` o similares:
```
# mybash configuration
if [ -f ~/.mybash/.init ]; then
    . ~/.mybash/.init
fi
```
1. Reinicia la consola