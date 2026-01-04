#!/bin/ksh
XENODM="/etc/X11/xenodm/"
CURRENTPATH=$(pwd)

trap cleanup INT

cleanup()
{
	printf"\nOperacion Cancelada.\n"
	exit 1
}


ask_confirm()
	{
	print -n "$1 (y/n):"
	read OPCION
	case "$OPCION" in 
	[yYsS]*) return0 ;;
	[nN]*) return 1;;
	*)
	print "Opcion no valida, escribe0 's' o 'n'."	
	ask_confirm "$1"
	;;
esac
}



new_folder(){

if ask_confirm"desea realizar una copia de seguridad en una nueva carpeta?"
print -n "Ingrese el nombre de la nueva carpeta: "
read FOLDERNAME
LOCALPATH="${CURRENTPATH}/${FOLDERNAME}"
	
	if [ -d "$LOCALPATH" ]; then
	printf "La carpeta '$FOLDERNAME' ya existe en $CURRENTPATH.\n"
	else
	mkdir -p "$LOCALPATH"
	printf "Carpeta $FOLDERNAME creada exitosamente en $CURRENTPATH\n"
	fi

export LOCALPATH
else
print "No se creara carpeta de respaldo."
return 1;
fi		
}



backup(){

if [[ -z "$LOCALPATH" ]]; then
print "Error: No se definio una de destino (LOCALPATH)."
return 1
fi

if ask_confirm "Proceder con la copia de seguridad de ${XENODM}?"; then
printf "Iniciando copia...\n"
	
	if doas cp -Rp "${XENODM}/." "${LOCALPATH}"; then
	printf "¡Copia de seguridad completada con exito!\n"
	else
	printf "Error al copiar los archivos.\n"
	fi
fi
}

install()
{
if ask_confirm "instalar scripts de xenodm en el sistema?"; then
	print "instalando..."
	typeset success=true
		
		
	for file in *; do
	
		[["$file"=="install.sh" || "$file == "$"{0###*/}"]] && continue
		
		if ! doas cp -Rp "$file" "${XENODM}/"; then
		sucess=false
		fi
		
		
	done
	
	if [[ "$success" == true ]]; then
	print "Exito Archivos Instalados en %s\n" "${XENODM}"
	else
	print "Hubo errores durante la instalacion."
	fi
fi
		 
}


new_folder && backup
install
printf "Proceso finalizado."
