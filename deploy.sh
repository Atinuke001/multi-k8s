docker build -t akinsanya4/multi-client:latest -t akinsanya4/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t akinsanya4/multi-server:latest -t akinsanya4/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t akinsanya4/multi-worker:latest -t akinsanya4/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push akinsanya4/multi-client:latest
docker push akinsanya4/multi-server:latest
docker push akinsanya4/multi-worker:latest

docker push akinsanya4/multi-client:$SHA
docker push akinsanya4/multi-server:$SHA
docker push akinsanya4/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=akinsanya4/multi-server:$SHA
kubectl set image deployments/client-deployment client=akinsanya4/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=akinsanya4/multi-worker:$SHA
