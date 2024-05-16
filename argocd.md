* GitHub:
  Create the GitHub Repo with  the yamls that were created as part of the move2kube transformation .
  which will be available under the
  myproject/deploy/ folder
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

* Deploy Argo cd application
```
 kubectl apply -f https://github.com/blcporgs/catalog-service-deployment/raw/main/argocd.yaml
```
Note: Change 'blob' to 'raw' in argocd.yaml file github url (https://github.com/blcporgs/catalog-service-deployment/blob/main/argocd.yaml)

* Update number of replicas in catalog-service-deployment.yaml file and see if changes are reflecting in argocd application.

#### Alternative way to launch Argo cd application

Launch  Argo cd application and configure the new Application like below .
* ArgoCD Configuration for application deployment

![alt text](image.png)
![alt text](image-1.png)



