docker build -t itykhan/multi-client:latest -t itykhan/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t itykhan/multi-server:latest -t itykhan/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t itykhan/multi-worker:latest -t itykhan/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push itykhan/multi-client:latest
docker push itykhan/multi-client:$SHA
docker push itykhan/multi-server:latest
docker push itykhan/multi-server:$SHA
docker push itykhan/multi-worker:latest
docker push itykhan/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=itykhan/multi-server:$SHA
kubectl set image deployments/client-deployment client=itykhan/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=itykhan/multi-worker:$SHA