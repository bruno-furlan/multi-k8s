docker build -t brunofurlan/multi-client:latest -t brunofurlan/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t brunofurlan/multi-server:latest -t brunofurlan/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t brunofurlan/multi-worker:latest -t brunofurlan/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push brunofurlan/multi-client
docker push brunofurlan/multi-server
docker push brunofurlan/multi-server
docker push brunofurlan/multi-client:$SHA
docker push brunofurlan/multi-server:$SHA
docker push brunofurlan/multi-server:$SHA
kubectl appy -f k8s
kubectl set image deployments/server-deployment server=brunofurlan/multi-server:$SHA
kubectl set image deployments/client-deployment client=brunofurlan/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=brunofurlan/multi-worker:$SHA
