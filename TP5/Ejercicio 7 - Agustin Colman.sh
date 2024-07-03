#!/bin/bash

function execute_rest {
    local url="$1"
    local response=$(curl -s "$url")
    echo "$response"
}

function validate_gender {
    local gender="$1"
    
    if [[ "$gender" == "male" ]]; then
        return 0
    elif [[ "$gender" == "female" ]]; then
        return 1
    else
        return 2
    fi
}


function validate_name {
    local name="$1"
    if [[ -z "$name" ]]; then
        return 1
    fi

    if [[ ! "$name" =~ ^[a-zA-Z]+$ ]]; then
        return 2
    fi

    return 0
}

while true; do
    while true; do
        read -p "Por favor, ingrese un nombre (o 'salir' para finalizar): " nombre
        
        if [[ "$nombre" == "salir" ]]; then
            echo "Fin del programa."
            exit 0
        fi

        validate_name "$nombre"
        valid_name=$?

        if [[ $valid_name -eq 0 ]]; then
            break
        elif [[ $valid_name -eq 1 ]]; then
            echo "Error: El nombre no puede estar vacio. Intente de nuevo."
        elif [[ $valid_name -eq 2 ]]; then
            echo "Error: El nombre solo puede contener letras. Intente de nuevo."
        fi
    done
    
    URL="https://api.genderize.io/?name=${nombre}"
    
    respuesta=$(execute_rest "$URL")
    
    gender=$(echo "$respuesta" | grep -o '"gender":"[^"]*' | cut -d'"' -f4)
    
    validate_gender "$gender"
    gender_code=$?
    
    if [[ $gender_code -eq 0 ]]; then
        echo "El nombre ingresado es del genero: Masculino"
    elif [[ $gender_code -eq 1 ]]; then
        echo "El nombre ingresado es del genero: Femenino"
   
    else
        echo "Perdon pero no pudimos determinar un genero para el nombre ingresado"
    fi
    
    read -p "¿Deseas consultar otro nombre? (s/n): " response
    if [[ $response != "s" ]]; then
        echo "Fin del programa."
        break
    fi
    clear
done
