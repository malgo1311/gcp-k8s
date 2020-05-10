docker build -t malgo1311/multi-client:latest -t malgo1311/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t malgo1311/multi-server:latest -t malgo1311/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t malgo1311/multi-worker:latest -t malgo1311/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push malgo1311/multi-client:latest
docker push malgo1311/multi-server:latest
docker push malgo1311/multi-worker:latest

docker push malgo1311/multi-client:$GIT_SHA
docker push malgo1311/multi-server:$GIT_SHA
docker push malgo1311/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=malgo1311/multi-client:$GIT_SHA
kubectl set image deployments/server-deployment server=malgo1311/multi-server:$GIT_SHA
kubectl set image deployments/worker-deployment worker=malgo1311/multi-worker:$GIT_SHA