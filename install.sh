#!/bin/ksh

XENODM="/etc/X11/xenodm/"
CURRENTPATH=$(pwd)
SCRIPT_NAME=$(basename "$0")
trap cleanup INT

cleanup() {
    printf "\nOperación Cancelada.\n"
    exit 1
}

ask_confirm() {
    print -n "$1 (s/n): "
    read OPCION
    case "$OPCION" in 
        [yYsS]*) return 0 ;;
        [nN]*) return 1 ;;
        *)
            print "Opción no válida, escribe 's' o 'n'."    
            ask_confirm "$1"
            ;;
    esac
}

new_folder() {
    if ask_confirm "¿Desea realizar una copia de seguridad en una nueva carpeta?"; then
        print -n "Ingrese el nombre de la nueva carpeta: "
        read FOLDERNAME
        LOCALPATH="${CURRENTPATH}/${FOLDERNAME}"
        
        if [ -d "$LOCALPATH" ]; then
            printf "La carpeta '%s' ya existe.\n" "$FOLDERNAME"
        else
            mkdir -p "$LOCALPATH"
            printf "Carpeta %s creada en %s\n" "$FOLDERNAME" "$CURRENTPATH"
        fi
        return 0
    else
        print "No se creará carpeta de respaldo."
        return 1
    fi      
}

backup() {
    if [[ -z "$LOCALPATH" ]]; then
        print "Error: No se definió destino (LOCALPATH)."
        return 1
    fi

    if ask_confirm "¿Proceder con la copia de seguridad de ${XENODM}?"; then
        printf "Iniciando copia...\n"
        if doas cp -Rp "${XENODM}." "${LOCALPATH}"; then
            printf "¡Copia de seguridad completada!\n"
        else
            printf "Error al copiar archivos.\n"
        fi
    fi
}

# instalacion del script en /etc/X11/xenodm
install() {
    if ask_confirm "¿Instalar scripts de xenodm en el sistema?"; then
        print "Instalando..."
        typeset success=true
            
        for file in scripts/*; do
        [[ -d "$file" ]] && continue
        
        if ! doas cp -Rp "$file" "${XENODM}/"; then
        printf "Error: No se pudo copiar %s\n" "$file"
        success=false
        fi
            
        done
        
        if [[ "$success" == "true" ]]; then
            printf "Éxito: Archivos instalados en %s\n" "${XENODM}"
        else
            print "Hubo errores durante la instalación."
        fi
    fi
}

# Ejecución principal
if new_folder; then
    backup
fi

install
printf "Proceso finalizado.\n"
