#!/bin/bash
#Author: Daniel Rueda Macías (559207)
#Comments: Script para transformar un fichero a sentencia de inserción sql
#Las líneas del fichero deben estar en el formato 'texto',num,..., (lista de valores
#dentro de la sentencia de inserción sql).
#Orden de parámtetros: ficheroDatos nombreTabla nombreNuevoFichero
if [ $# -lt 3 ]; then
	echo "Parámetros mal introducidos. Orden de parámetros:"
	echo "ficheroDatos nombreTabla nombreFicheroACrear"
else
	cat $1 | while read linea
	do
		echo "INSERT INTO $2 VALUES ($linea);" >> $3
	done
fi