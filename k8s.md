# Kubernetes Cheet-sheet
In this document we will see the useful commands for the kubernetes

### POD

#### How to create a Pod in kubernetes

```
kubectl run nginx --image nginx:latest
```

#### How to list pods 

```
kubectl get po
```
```
kubectl get po
NAME    READY   STATUS    RESTARTS   AGE
nginx   1/1     Running   0          79s
```
#### How to save the Pod configuration file in Yaml format without creating a Pod

```
kubectl run nginx --image nginx --dry-run=client -o yaml
```
```
 kubectl run nginx --image nginx --dry-run=client -o yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: nginx
  name: nginx
spec:
  containers:
  - image: nginx
    name: nginx
```

* To save this configuration file 
```
kubectl run nginx --image nginx --dry-run=client -o yaml > pod-defination.yaml
```
* To delete the pod
```
kubectl delete pod nginx
```

```
kubectl delete pod nginx
pod "nginx" deleted
```

* To describe the pod

```
kubectl describe pod nginx
```

```
 kubectl describe pod nginx
Name:             nginx
Namespace:        default
Priority:         0
Service Account:  default
Node:             test/10.0.0.4
Start Time:       Mon, 13 May 2024 06:44:10 +0000
Labels:           run=nginx
Annotations:      <none>
Status:           Running
IP:               10.32.0.4
IPs:
  IP:  10.32.0.4
Containers:
  nginx:
    Container ID:   containerd://7f2dbf68b4e9168425dd1f13be33eb17b8f1202171d91bce74e4c35e69b8ddb2
    ------------------------
```

* To save already created pod configuration file as yaml file

```
kubectl get pod nginx -o yaml > pod-configuration.yaml
```

* To edit a already created pod 

```
kubectl edit pod nginx
```

### Deployment
#### How to Manage deployment

* How to create deployment

```
kubectl create deployment nginx --image=nginx
```

```
kubectl create deployment nginx --image=nginx
deployment.apps/nginx created
```

* How to list deployment

```
kubectl get deploy
```

```
kubectl get deploy
NAME    READY   UP-TO-DATE   AVAILABLE   AGE
nginx   1/1     1            1           37s
```

* To describe the deployment

```
kubectl describe deployment nginx
```

* How to save deployment configuration file

```
kubectl create deployment --image=nginx nginx --dry-run=client -o yaml > deployment-configuration.yaml
```

* Generate Deployment with 4 Replicas 

```
kubectl create deployment nginx --image=nginx --replicas=4
```

### Replicaset

* To create a Replicaset use the yaml defination file

```
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: nginx-replicaset
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:latest
```
* Save this file, and then create the replicaset using the below command

```
kubectl apply -f rs.yaml
```
Here rs.yaml is the file name

```
kubectl apply -f rs.yaml
replicaset.apps/nginx-replicaset created
```

* To get the replicaset available in cluster

```
kubectl get rs
```

```
 kubectl get rs
NAME               DESIRED   CURRENT   READY   AGE
nginx-7854ff8877   1         1         1       27m
nginx-replicaset   2         2         2       3m20s
```

* To scale the replicaset

```
kubectl scale --replicas=3 -f rs.yaml
```

```
kubectl scale --replicas=3 -f rs.yaml
replicaset.apps/nginx-replicaset scaled
```

* To delete the replicasrt created using yaml file

```
kubectl delete -f rs.yaml
```

```
kubectl delete -f rs.yaml
replicaset.apps "nginx-replicaset" deleted
```
### Statefulset

```
apiVersion: v1
kind: Service
metadata:
  name: nginx
  labels:
    app: nginx
spec:
  ports:
  - port: 80
    name: web
  clusterIP: None
  selector:
    app: nginx
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: web
spec:
  selector:
    matchLabels:
      app: nginx # has to match .spec.template.metadata.labels
  serviceName: "nginx"
  replicas: 3 # by default is 1
  minReadySeconds: 10 # by default is 0
  template:
    metadata:
      labels:
        app: nginx # has to match .spec.selector.matchLabels
    spec:
      terminationGracePeriodSeconds: 10
      containers:
      - name: nginx
        image: nginx
        ports:
        - containerPort: 80
          name: web
        volumeMounts:
        - name: www
          mountPath: /usr/share/nginx/html
  volumeClaimTemplates:
  - metadata:
      name: www
    spec:
      accessModes: 
      - ReadWriteOnce
      storageClassName: 
      resources:
        requests:
          storage: 1Gi
```

* Save this file and create a statefullset

### ConfigMap

```
kubectl create configmap \app-config --from-literal=APP_COLOR=blue
```

```
ubuntu@test:~$ kubectl create configmap \app-config --from-literal=APP_COLOR=blue
configmap/app-config created
kubectl get configmap
NAME               DATA   AGE
app-config         1      11s
kube-root-ca.crt   1      6h1m
```
### Secret

```
kubectl create secret generic \app-secret --from-literal=DB_host=mysql
```

```
kubectl create secret generic \app-secret --from-literal=DB_host=mysql
secret/app-secret created
ubuntu@test:~$ k get secret
NAME         TYPE     DATA   AGE
app-secret   Opaque   1      12s
```

### Services

#### ClusterIp:
```
kubectl expose pod nginx --port=80 --name nginx-service
```
```
kubectl expose pod nginx --port=80 --name nginx-service
service/nginx-service exposed
kubectl get svc
NAME            TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)   AGE
kubernetes      ClusterIP   10.96.0.1      <none>        443/TCP   6h20m
nginx           ClusterIP   None           <none>        80/TCP    47m
nginx-service   ClusterIP   10.107.238.2   <none>        80/TCP    10s
```

#### NodePort:

```
kubectl expose pod nginx --type=NodePort --port=80 --name=nginx-service
```

```
kubectl expose pod nginx --type=NodePort --port=80 --name=nginx-service
service/nginx-service exposed
```

#### LoadBalancer:

This service is available in cloud environment and needs to check with cloud provider for this

### Ingress

* Ingress rule

```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: minimal-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  ingressClassName: nginx-example
  rules:
  - http:
      paths:
      - path: /testpath
        pathType: Prefix
        backend:
          service:
            name: test
            port:
              number: 80
```

* To use the ingress rule we need have ingress controller in the cluster some examples of ingress controller are nginx-ingress

### PV & PVC

pv-definition.yaml
```
apiVersion: v1
kind: PersistentVolume
metadata:
  name: my-pv
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: standard
  hostPath:
    path: /tmp/data

---

apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
  storageClassName: standard
  volumeName: my-pv


```

```
kubectl apply -f pv-definition.yaml
```

```
kubectl apply -f pv-definition.yaml
persistentvolume/my-pv created
persistentvolumeclaim/my-pvc created
kubectl get pv
NAME    CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM            STORAGECLASS   REASON   AGE
my-pv   1Gi        RWO            Retain           Bound    default/my-pvc   standard                5s
kubectl get pvc
NAME        STATUS    VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS       AGE
my-pvc      Pending   my-pv    0                         standard           10s
```
