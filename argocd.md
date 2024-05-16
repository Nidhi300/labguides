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

* Performed the scaled down directly from the cluster, But  we have mentioned replicas as 2 in yamls, argocd deployed another pod automatically

```

ubuntu@ubuntu:~$ kubectl scale deployment catalog-service  --replicas=1

deployment.apps/catalog-service scaled
ubuntu@ubuntu:~$ kubectl get po

NAME                                     READY   STATUS        RESTARTS        AGE
adservice-587cf5987f-7brxz               2/2     Running       0               50d
amt                                      2/2     Running       0               27d
cartservice-7958c76db4-mmwh2             2/2     Running       0               50d
catalog-service-966744bfc-b6lg7          2/2     Running       0               8m41s
catalog-service-966744bfc-jlbvl          2/2     Running       0               5s
catalog-service-966744bfc-r4mg5          0/2     Terminating   0               2m30s

ubuntu@ubuntu:~$ kubectl get po

NAME                                     READY   STATUS    RESTARTS        AGE
adservice-587cf5987f-7brxz               2/2     Running   0               50d
amt                                      2/2     Running   0               27d
cartservice-7958c76db4-mmwh2             2/2     Running   0               50d
catalog-service-966744bfc-b6lg7          2/2     Running   0               9m
catalog-service-966744bfc-jlbvl          2/2     Running   0               24s

```
Launch  Argo cd application and configure the new Application like below .
* ArgoCD Configuration for application deployment

![alt text](image.png)
![alt text](image-1.png)



