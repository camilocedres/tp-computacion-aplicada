#!/bin/bash

# === FUNCION AYUDA ===
if [[ "$1" == "-help" ]]; then
    echo "Uso: $0 <origen> <destino>"
    echo "Ejemplo: $0 /var/log /backup_dir"
    exit 0
fi

# === VALIDACION DE ARGUMENTOS ===
ORIGEN="$1"
DESTINO="$2"

if [[ -z "$ORIGEN" || -z "$DESTINO" ]]; then
    echo "Error: Debe indicar origen y destino. Use -help para más información."
    exit 1
fi

# === VALIDAR QUE DIRECTORIOS EXISTAN ===
if [[ ! -d "$ORIGEN" ]]; then
    echo "Error: Origen '$ORIGEN' no existe."
    exit 1
fi

if [[ ! -d "$DESTINO" ]]; then
    echo "Error: Destino '$DESTINO' no existe."
    exit 1
fi

# === CREAR BACKUP CON FECHA ===
FECHA=$(date +%Y%m%d)
NOMBRE_ORIGEN=$(basename "$ORIGEN" | sed 's|/||g')
ARCHIVO="${NOMBRE_ORIGEN}_bkp_${FECHA}.tar.gz"

tar -czf "$DESTINO/$ARCHIVO" "$ORIGEN"

if [[ $? -eq 0 ]]; then
    echo "✅ Backup completado: $DESTINO/$ARCHIVO"
else
    echo "❌ Error durante el backup"
fi
