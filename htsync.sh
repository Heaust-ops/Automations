# this syncs htdocs folder in my projects directory to the main one in the lampp directory

while true; do 
  sleep 1
  inotifywait -r -e modify,create,delete,move /home/heaust/Desktop/Directories/MyProjects/htdocs
  rsync --delete -avz /home/heaust/Desktop/Directories/MyProjects/htdocs /opt/lampp/
done
