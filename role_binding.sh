kubectl create sa cicd-token -n app-team1
kubectl create clusterrole deployment-clusterrole --verb=create --resource=deployments,statefulsets,daemonsets
kubectl create clusterrolebinding binding --clusterrole=deployment-clusterrole --serviceaccount=app-team1:cicd-token -n app-team1

kubectl create ns apps
kubectl create sa pod-access -n apps
kubectl create role pod-role --verb=get,list,watch --resource=pods -n apps
kubectl create rolebinding pod-rolebinding --role=pod-role --serviceaccount=apps:pod-acess -n apps
