1. git clone https://github.com/cmotta2016/multi-k8s.git

2. Criar projeto no GC

3. Criar Cluster Kubernetes

4. Generating Service Account (Project Role: Kubernetes Engine Admin)

5. Configurar o Travis com a service account
```
Copiar o arquivo service-account.json para o volume do container e renomeá-lo para simplificar

$ docker run -it -v $(pwd):/app ruby:2.3 sh
# gem install travis
# travis login --> se aparecer alguma mensagem de shell escolhe não
# travis encrypt-file service-account.json -r cmotta2016/multi-k8s
```

6. Editar o arquivo .travis.yml
```
Adicionar a saída gerada pelo comando acima logo após o bloco before_install
Atualizar as informações de projeto, zona e nome do cluster
Adicionar o arquivo service-account.json.enc no github repositório
```

7. No Travis CI, adicionar as variáveis DOCKER_USERNAME e DOCKER_PASSWORD

8. Configurar o gcloud cli no cloud console
```
$ gcloud config set project <PROJECTID>
$ gcloud config set compute/zone <ZONE>
$ gcloud container clusters get-credentials <NOME_DO_CLUSTER>
```

9. Criando secrets no google cloud
```
$ kubectl create secret generic pgpassword --from-literal PGPASSWORD=pgpassword
$ Kubernetes Engine > Configuration
```

10. Configurando Helm
```
$ curl https://raw.githubusercontent.com/helm/helm/master/scripts/get > get_helm.sh
$ chmod 700 get_helm.sh
$ ./get_helm.sh
```

11. Definir uma service account para o Tiller (servidor do Helm)
```
$ kubectl create serviceaccount --namespace kube-system tiller
$ kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
$ helm init --service-account tiller --upgrade
```

12. Configurar ingress/Load Balancer
```
$ helm install stable/nginx-ingress --name my-nginx --set rbac.create=true
```

13. Fazendo o deploy
```
$ git commit -a -m "Commit"
$ git push origin master
```

14. Checar no Workload os pods iniciados e Services

15. Efetuando uma alteração na aplicação após o deploy
```
$ git checkout -b devel
$ cd client/src
$ vim App.js
Alterar o App-title
$ git commit -a -m "changed app.js"
$ git push origin devel

No github criar o pull request:
Pull requests > New pull request > base:master compare:devel > create pull request > Merge pull request
```
