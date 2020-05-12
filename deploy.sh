docker build -t kiwamoto/multi-server:latest -t kiwamoto/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kiwamoto/multi-worker:latest -t kiwamoto/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker build -t kiwamoto/multi-client:latest -t kiwamoto/multi-client:$SHA -f ./client/Dockerfile ./client

docker push kiwamoto/multi-server:latest
docker push kiwamoto/multi-worker:latest
docker push kiwamoto/multi-client:latest

docker push kiwamoto/multi-server:$SHA
docker push kiwamoto/multi-worker:$SHA
docker push kiwamoto/multi-client:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kiwamoto/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=kiwamoto/multi-worker:$SHA
kubectl set image deployments/client-deployment client=kiwamoto/multi-client:$SHA