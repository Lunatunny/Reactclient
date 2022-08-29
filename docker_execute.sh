docker build -t reactclient:v1.0 .
docker stop reactclient || true && docker start reactclient || true
docker rm reactclient
docker run -dit --name reactclient -p 3000:80 reactclient:v1.0
docker network connect mccnetwork reactclient 
