docker build -t regalme/multi-client:latest -t regalme/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t regalme/multi-server:latest -t regalme/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t regalme/multi-worker:latest -t regalme/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push regalme/multi-client:latest
docker push regalme/multi-server:latest
docker push regalme/multi-worker:latest
docker push regalme/multi-client:$SHA
docker push regalme/multi-server:$SHA
docker push regalme/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server server=regalme/multi-server:$SHA
kubectl set image deployments/client client=regalme/multi-client:$SHA
kubectl set image deployments/worker worker=regalme/multi-worker:$SHA