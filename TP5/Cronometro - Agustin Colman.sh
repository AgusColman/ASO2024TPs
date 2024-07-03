#!/bin/bash

format_time() {
    local total_seconds="$1"
    local hours=$(( total_seconds / 3600 ))
    local minutes=$(( (total_seconds % 3600) / 60 ))
    local seconds=$(( total_seconds % 60 ))
    printf "%02d:%02d:%02d" $hours $minutes $seconds
}

run_stopwatch() {
    local start_time=$(date +%s) 
    local formatted_time=""
    local key_pressed

    clear  
    echo "                     Cronómetro                          "
    echo "========================================================="
    echo "Presiona cualquier tecla para detener el cronómetro."

    while true; do
        current_time=$(date +%s)
        elapsed_seconds=$(( current_time - start_time ))
        new_formatted_time=$(format_time $elapsed_seconds)
        
        if [ "$new_formatted_time" != "$formatted_time" ]; then
            formatted_time="$new_formatted_time"
            printf "\r%40s" "Tiempo transcurrido: $formatted_time"
        fi
        
        read -t 0.1 -n 1 key_pressed
        if [[ $key_pressed ]]; then
            break
        fi
    done
    
    echo -e "\nCronómetro detenido. Tiempo total: $formatted_time"
}


while true; do
    clear  
    
    echo "                     Cronómetro                          "
    echo "========================================================="
    read -n 1 -s -r -p "Presiona cualquier tecla para iniciar el cronómetro..."

    run_stopwatch

    # Preguntar al usuario si quiere reiniciar o salir
    read -p "¿Quieres reiniciar el cronómetro? (s/n): " answer
    case $answer in
        [Ss]* ) continue;;
        [Nn]* ) break;;
        * ) echo "Respuesta invalida. Saliendo del script."; break;;
    esac
done