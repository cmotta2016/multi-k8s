docker build -t cmotta2016/multi-client:latest -t cmotta2016/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t cmotta2016/multi-server:latest -t cmotta2016/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t cmotta2016/multi-worker:latest -t cmotta2016/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push cmotta2016/multi-client:latest
docker push cmotta2016/multi-client:$SHA
docker push cmotta2016/multi-server:latest
docker push cmotta2016/multi-server:$SHA
docker push cmotta2016/multi-worker:latest
docker push cmotta2016/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=cmotta2016/multi-server:$SHA
kubectl set image deployments/client-deployment client=cmotta2016/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=cmotta2016/multi-worker:$SHA
