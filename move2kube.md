* To install move2kube in system

```
bash <(curl https://raw.githubusercontent.com/konveyor/move2kube/main/scripts/install.sh)
```

* To download the demo application

```

```

* create one directory and move the download application to that folder

```
mkdir move2kubeHome
````

```
mv catalog-service-v1/ move2kubeHome/
```

* Go to the move2kubeHome directory

```
cd move2kubeHome
```

* Now we will transform the code to K8s

```
move2kube transform -s catalog-service-v1/
```

* m2kconfig file content

```
move2kube:
  minreplicas: "1"
  repo:
    keys:
      pub:
        load: false
  services:
    catalog-service:
      "8080":
        servicetype: ClusterIP
      childModules:
        catalog-service:
          port: "8080"
          springBootProfiles:
            - dev
            - local
      dockerfileType: no build stage
      enable: true
      statefulset: false
    catalog-service-v1:
      containerizationoption:
        - Jar
      enable: true
  spawncontainers: true
  target:
    default:
      clustertype: Kubernetes
    imageregistry:
      index.docker.io:
        logintype: username and password
        username: korificf
      namespace: korificf
      url: index.docker.io
  transformers:
    kubernetes:
      argocd:
        namespace: ""
    types:
      - ArgoCD
      - Buildconfig
      - CNBContainerizer
      - CloudFoundry
      - ClusterSelector
      - ComposeAnalyser
      - ComposeGenerator
      - ContainerImagesPushScriptGenerator
      - DockerfileDetector
      - DockerfileImageBuildScript
      - DockerfileParser
      - DotNetCore-Dockerfile
      - EarAnalyser
      - EarRouter
      - Golang-Dockerfile
      - Gradle
      - Jar
      - Jboss
      - Knative
      - Kubernetes
      - KubernetesVersionChanger
      - Liberty
      - Maven
      - Nodejs-Dockerfile
      - OperatorTransformer
      - OperatorsFromTCA
      - PHP-Dockerfile
      - Parameterizer
      - Python-Dockerfile
      - ReadMeGenerator
      - Ruby-Dockerfile
      - Rust-Dockerfile
      - Tekton
      - Tomcat
      - WarAnalyser
      - WarRouter
      - WinWebApp-Dockerfile
      - ZuulAnalyser
  transformerselector: ""
```

* m2kqacache file content

```
apiVersion: move2kube.konveyor.io/v1alpha1
kind: QACache
spec:
  solutions:
    - id: move2kube.transformerselector
      type: Input
      description: Specify a Kubernetes style selector to select only the transformers that you want to run.
      hints:
        - Leave empty to select everything. This is the default.
      default: ""
      answer: ""
    - id: move2kube.transformers.types
      type: MultiSelect
      description: 'Select all transformer types that you are interested in:'
      hints:
        - Services that don't support any of the transformer types you are interested in will be ignored.
      options:
        - ArgoCD
        - Buildconfig
        - CNBContainerizer
        - CloudFoundry
        - ClusterSelector
        - ComposeAnalyser
        - ComposeGenerator
        - ContainerImagesPushScriptGenerator
        - DockerfileDetector
        - DockerfileImageBuildScript
        - DockerfileParser
        - DotNetCore-Dockerfile
        - EarAnalyser
        - EarRouter
        - Golang-Dockerfile
        - Gradle
        - Jar
        - Jboss
        - Knative
        - Kubernetes
        - KubernetesVersionChanger
        - Liberty
        - Maven
        - Nodejs-Dockerfile
        - OperatorTransformer
        - OperatorsFromTCA
        - PHP-Dockerfile
        - Parameterizer
        - Python-Dockerfile
        - ReadMeGenerator
        - Ruby-Dockerfile
        - Rust-Dockerfile
        - Tekton
        - Tomcat
        - WarAnalyser
        - WarRouter
        - WinConsoleApp-Dockerfile
        - WinSLWebApp-Dockerfile
        - WinWebApp-Dockerfile
        - ZuulAnalyser
      default:
        - ArgoCD
        - DockerfileParser
        - Buildconfig
        - Gradle
        - Maven
        - Jboss
        - ZuulAnalyser
        - Kubernetes
        - EarAnalyser
        - ContainerImagesPushScriptGenerator
        - Golang-Dockerfile
        - Jar
        - DotNetCore-Dockerfile
        - CloudFoundry
        - ClusterSelector
        - Rust-Dockerfile
        - WarRouter
        - CNBContainerizer
        - WinWebApp-Dockerfile
        - Tekton
        - OperatorTransformer
        - WarAnalyser
        - Ruby-Dockerfile
        - Knative
        - KubernetesVersionChanger
        - DockerfileDetector
        - OperatorsFromTCA
        - Liberty
        - Nodejs-Dockerfile
        - Python-Dockerfile
        - DockerfileImageBuildScript
        - Tomcat
        - ReadMeGenerator
        - EarRouter
        - Parameterizer
        - ComposeGenerator
        - ComposeAnalyser
        - PHP-Dockerfile
      answer:
        - ArgoCD
        - Buildconfig
        - CNBContainerizer
        - CloudFoundry
        - ClusterSelector
        - ComposeAnalyser
        - ComposeGenerator
        - ContainerImagesPushScriptGenerator
        - DockerfileDetector
        - DockerfileImageBuildScript
        - DockerfileParser
        - DotNetCore-Dockerfile
        - EarAnalyser
        - EarRouter
        - Golang-Dockerfile
        - Gradle
        - Jar
        - Jboss
        - Knative
        - Kubernetes
        - KubernetesVersionChanger
        - Liberty
        - Maven
        - Nodejs-Dockerfile
        - OperatorTransformer
        - OperatorsFromTCA
        - PHP-Dockerfile
        - Parameterizer
        - Python-Dockerfile
        - ReadMeGenerator
        - Ruby-Dockerfile
        - Rust-Dockerfile
        - Tekton
        - Tomcat
        - WarAnalyser
        - WarRouter
        - WinWebApp-Dockerfile
        - ZuulAnalyser
    - id: move2kube.spawncontainers
      type: Confirm
      description: Allow spawning containers?
      hints:
        - If this setting is set to false, those transformers that rely on containers will not work.
      default: false
      answer: true
    - id: move2kube.services.[].enable
      type: MultiSelect
      description: 'Select all services that are needed:'
      hints:
        - The services unselected here will be ignored.
      options:
        - catalog-service
        - catalog-service-v1
      default:
        - catalog-service
        - catalog-service-v1
      answer:
        - catalog-service
        - catalog-service-v1
    - id: move2kube.services."catalog-service-v1".containerizationoption
      type: MultiSelect
      description: 'Select the transformer to use for containerizing the ''catalog-service-v1'' service :'
      options:
        - Jar
      default:
        - Jar
      answer:
        - Jar
    - id: move2kube.services."catalog-service".dockerfileType
      type: Select
      description: What type of Dockerfiles should be generated for the service 'catalog-service'?
      hints:
        - '[no build stage] There is no build stage. Dockerfiles will only contain the run stage. The jar/war/ear files will need to be built and present in the file system already, for them to get copied into the container.'
        - '[build stage in base image] Put the build stage in a separate Dockerfile and create a base image.'
        - '[build stage in every image] Put the build stage in every Dockerfile to make it self contained. (Warning: This may cause one build per Dockerfile.)'
      options:
        - no build stage
        - build stage in base image
        - build stage in every image
      default: build stage in base image
      answer: no build stage
    - id: move2kube.services."catalog-service".childModules."catalog-service".springBootProfiles
      type: MultiSelect
      description: 'Select the spring boot profiles for the service ''catalog-service'' :'
      hints:
        - select all the profiles that are applicable
      options:
        - dev
        - local
      default:
        - dev
        - local
      answer:
        - dev
        - local
    - id: move2kube.services."catalog-service".childModules."catalog-service".port
      type: Select
      description: 'Select the port to be exposed for the ''"catalog-service".childModules."catalog-service"'' service :'
      hints:
        - Select 'Other' if you want to expose the service using a different port.
      options:
        - "8080"
        - Other (specify custom option)
      default: "8080"
      answer: "8080"
    - id: move2kube.target.imageregistry.url
      type: Select
      description: 'Enter the URL of the image registry where the new images should be pushed : '
      hints:
        - You can always change it later by changing the yamls.
      options:
        - Other (specify custom option)
        - index.docker.io
        - quay.io
      default: quay.io
      answer: index.docker.io
    - id: move2kube.target.imageregistry.namespace
      type: Input
      description: 'Enter the namespace where the new images should be pushed : '
      hints:
        - 'Ex : myproject'
      default: myproject
      answer: korificf
    - id: move2kube.target."default".clustertype
      type: Select
      description: 'Choose the cluster type:'
      hints:
        - Choose the cluster type you would like to target
      options:
        - AWS-EKS
        - Azure-AKS
        - GCP-GKE
        - IBM-IKS
        - IBM-Openshift
        - Kubernetes
        - Openshift
      default: Kubernetes
      answer: Kubernetes
    - id: move2kube.services.catalog-service.statefulset
      type: Confirm
      description: For the service 'catalog-service', do you require a StatefulSet instead of a Deployment?
      default: false
      answer: false
    - id: move2kube.services."catalog-service"."8080".servicetype
      type: Select
      description: What kind of service/ingress should be created for the service catalog-service's 8080 port?
      hints:
        - Choose Ingress if you want a ingress/route resource to be created
      options:
        - Ingress
        - LoadBalancer
        - NodePort
        - ClusterIP
        - Don't create service
      default: Ingress
      answer: ClusterIP
    - id: move2kube.minreplicas
      type: Input
      description: Provide the minimum number of replicas each service should have
      hints:
        - If the value is 0 pods won't be started by default
      default: "2"
      answer: "1"
    - id: move2kube.target.imageregistry."index.docker.io".logintype
      type: Select
      description: '[index.docker.io] What type of container registry login do you want to use?'
      options:
        - use an existing pull secret
        - no authentication
        - username and password
      default: no authentication
      answer: username and password
    - id: move2kube.target.imageregistry."index.docker.io".username
      type: Input
      description: '[index.docker.io] Enter the username to login into the registry : '
      default: iamapikey
      answer: korificf
    - id: move2kube.transformers.kubernetes.argocd.namespace
      type: Input
      description: Enter the destination namespace for the Argo CD pipeline
      hints:
        - If Argo CD pipeline is not relevant to you, then leave empty to use the default value for it.
      default: ""
      answer: ""
    - id: move2kube.repo.keys.pub.load
      type: Confirm
      description: |-
        The CI/CD pipeline needs access to the git repos in order to clone, build and push.
        Move2Kube has public keys for github.com, gitlab.com, and bitbucket.org by default.
        If any of the repos use ssh authentication we will need public keys in order to verify.
        Do you want to load the public keys from your [/home/ubuntu/.ssh/known_hosts]?:
      hints:
        - No, I will add them later if necessary.
      default: false
      answer: false
```

* You will get this files inside the move2kubeHome directory

```
ubuntu@ubuntu:~/move2kubeHome$ ls
catalog-service-v1  m2kconfig.yaml  m2kqacache.yaml  myproject
```

* Once move2kube convert the code to the k8s supporting you will get the 'myproject' directory inside the move2kubeHome folder.

# Knative Support

* Knative yaml file

  ```
  apiVersion: serving.knative.dev/v1
kind: Service
metadata:
  creationTimestamp: null
  labels:
    move2kube.konveyor.io/service: catalog-service-v1
  name: catalog-service-v1
spec:
  template:
    metadata:
      creationTimestamp: null
    spec:
      containers:
        - image: index.docker.io/korificf/catalog-service-v1:latest
          imagePullPolicy: Always
          name: catalog-service-v1
          ports:
            - containerPort: 8080
          resources:
            requests:
              ephemeral-storage: "0"
              memory: "0"
      imagePullSecrets:
        - name: index-docker-io-imagepullsecret
      restartPolicy: Always
      securityContext: {}
status: {}
```
