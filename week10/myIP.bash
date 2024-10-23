ip addr | grep 'inet' | awk '/scope global/ {print$2}' | cut -d'/' -f1
