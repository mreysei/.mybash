# mybash

## Configuración

Añadir al final de tu `.bashrc`, `.zshrc` o similares:
```
# mybash configuration
if [ -f ~/.mybash/.init ]; then
    . ~/.mybash/.init
fi
```
