ip addr | awk '/scope global/ {print}' | cut -c 10-19
