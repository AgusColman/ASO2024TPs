#!/bin/bash

numero_aleatorio=$((RANDOM % 100 + 1))

echo "Bienvenido al juego de adivinar el número!"
echo "Tienes que adivinar un número entre 1 y 100." 

function validar_numero {
    re='^[0-9]+$'
    if ! [[ $1 =~ $re ]] ; then
        echo "Error: Por favor ingresa un número válido."
        return 1
    fi
    if [[ $1 -lt 1 || $1 -gt 100 ]]; then
        echo "Error: El número debe estar entre 1 y 100."
        return 1
    fi
    return 0
}

while true; do
    read -p "Ingresa tu intento: " intento


    if validar_numero $intento; then
        if [[ $intento -eq $numero_aleatorio ]]; then
            echo "¡Felicidades! ¡Adivinaste el número $numero_aleatorio!"
            break
        elif [[ $intento -lt $numero_aleatorio ]]; then
            echo "El número es demasiado bajo. Intenta de nuevo."
        else
            echo "El número es demasiado alto. Intenta de nuevo."
        fi
    fi
done