* GitHub:
  Create the GitHub Repo with  the yamls that were created as part of the move2kube transformation .
  which will be available under the
  myproject/deply/ folder
  and also the argocd yaml available under the myproject/deploy/cicd/argocd.
  Edit the argocd.yaml file to add the below entries 
```
https://github.com/blcporgs/catalog-service-deployment/
```

* argocd.yaml
```
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: catalogservice
  namespace: argocd
spec:
  destination:
    server: https://kubernetes.default.svc
    namespace: default
  project: "default"
  syncPolicy:   
    syncOptions:
    - CreateNamespace=true
    automated:
      selfHeal: true
      prune: true

  source:
    path: yamls
    repoURL:  https://github.com/blcporgs/catalog-service-deployment.git
```

* Performed the scaled down directly from the cluster, But  we have mentioned replicas as 2 in yamls argocd deployed another pod automatically

```

ubuntu@ubuntu:~$ kubectl scale deployment catalog-service  --replicas=1
Warning: Use tokens from the TokenRequest API or manually created secret-based tokens instead of auto-generated secret-based tokens.
deployment.apps/catalog-service scaled
ubuntu@ubuntu:~$ kubectl get po
Warning: Use tokens from the TokenRequest API or manually created secret-based tokens instead of auto-generated secret-based tokens.
NAME                                     READY   STATUS        RESTARTS        AGE
adservice-587cf5987f-7brxz               2/2     Running       0               50d
amt                                      2/2     Running       0               27d
cartservice-7958c76db4-mmwh2             2/2     Running       0               50d
catalog-service-966744bfc-b6lg7          2/2     Running       0               8m41s
catalog-service-966744bfc-jlbvl          2/2     Running       0               5s
catalog-service-966744bfc-r4mg5          0/2     Terminating   0               2m30s
checkoutservice-5c5df86f8f-zrpz7         2/2     Running       0               50d
currencyservice-66dc4ff95c-vslgg         2/2     Running       1 (2d20h ago)   50d
emailservice-5847c9979-ms4zm             2/2     Running       0               50d
frontend-7cc7599865-4g78k                2/2     Running       0               50d
loadgenerator-84cc74dcd-7r5vl            2/2     Running       28 (28h ago)    50d
paymentservice-75c5d46bc5-6qm6f          2/2     Running       0               50d
productcatalogservice-65dffbf4bf-9c882   2/2     Running       0               50d
recommendationservice-7f58c78487-crqjp   2/2     Running       0               50d
redis-cart-76b9545755-prjnq              2/2     Running       0               50d
shippingservice-6bd977bbdc-zw45z         2/2     Running       0               50d
ubuntu@ubuntu:~$ kubectl get po
Warning: Use tokens from the TokenRequest API or manually created secret-based tokens instead of auto-generated secret-based tokens.
NAME                                     READY   STATUS    RESTARTS        AGE
adservice-587cf5987f-7brxz               2/2     Running   0               50d
amt                                      2/2     Running   0               27d
cartservice-7958c76db4-mmwh2             2/2     Running   0               50d
catalog-service-966744bfc-b6lg7          2/2     Running   0               9m
catalog-service-966744bfc-jlbvl          2/2     Running   0               24s
checkoutservice-5c5df86f8f-zrpz7         2/2     Running   0               50d
currencyservice-66dc4ff95c-vslgg         2/2     Running   1 (2d20h ago)   50d
emailservice-5847c9979-ms4zm             2/2     Running   0               50d
frontend-7cc7599865-4g78k                2/2     Running   0               50d
loadgenerator-84cc74dcd-7r5vl            2/2     Running   28 (28h ago)    50d
paymentservice-75c5d46bc5-6qm6f          2/2     Running   0               50d
productcatalogservice-65dffbf4bf-9c882   2/2     Running   0               50d
recommendationservice-7f58c78487-crqjp   2/2     Running   0               50d
redis-cart-76b9545755-prjnq              2/2     Running   0               50d
shippingservice-6bd977bbdc-zw45z         2/2     Running   0               50d
```
Launch  Argo cd application and configure the new Application like below .
* ArgoCD Configuration for application deployment

![alt text](image.png)
![alt text](image-1.png)



