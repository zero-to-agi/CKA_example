### 쿠버네티스 업그레이드하기

https://v1-30.docs.kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-upgrade/
```
kubectl get nodes
===================
NAME          STATUS   ROLES           AGE    VERSION
k8s-master    Ready    control-plane   225d   v1.30.0   # version 확인 가능
k8s-worker1   Ready    <none>          225d   v1.30.0
k8s-worker2   Ready    <none>          225d   v1.30.0
```
1) Master node 업그레이드

1. kubeadm 업그레이드
```
sudo apt-mark unhold kubeadm
sudo apt-get update
sudo apt-get install -y kubeadm='1.30.3-*'
sudo apt-mark hold kubeadm 
# hold 자동 업데이트 안되도록 하는 기능 (업데이트 막아놓기)

kubeadm 업그레이드 확인
kubeadm version
현재 버전을 기준으로 업그레이드 할 수 있는 버전들이 무엇인지 확인
sudo kubeadm upgrade plan
```

2. 컴포넌트 업그레이드
```
sudo kubeadm upgrade apply v1.30.3
===================
SUCCESS! Your cluster was upgraded to "v1.30.3". Enjoy!
```

4. pod 비우기
```
kubectl drain k8s-master --ignore-daemonsets
```
6. kubelet과 kubectl 업그레이드
```
sudo apt-mark unhold kubelet kubectl
sudo apt-get update
sudo apt-get install -y kubelet='1.30.3-*' kubectl='1.30.3-*'
sudo apt-mark hold kubelet kubectl

kubectl uncorod k8s-master
```
5. 업그레이드 된것 확인
```
kubectl get nodes
NAME          STATUS   ROLES           AGE    VERSION
k8s-master    Ready    control-plane   225d   v1.30.3
k8s-worker1   Ready    <none>          225d   v1.30.0
k8s-worker2   Ready    <none>          225d   v1.30.0
```
2) Worker node 업그레이드
1. kubeadm 업그레이드 (여기까지는 동일)
```
sudo apt-mark unhold kubeadm && \
sudo apt-get update && sudo apt-get install -y kubeadm='1.30.x-*' && \
sudo apt-mark hold kubeadm
```
3. 컴포넌트 업그레이드

```
sudo kubeadm upgrade node
```
5. console 에서 drain으로 비우기
sudo kubectl drain node_name

7. kubelet과 kubectl 업그레이드 (동일)
```
sudo apt-mark unhold kubelet kubectl && \
sudo apt-get update && sudo apt-get install -y kubelet='1.30.x-*' kubectl='1.30.x-*' && \
sudo apt-mark hold kubelet kubectl
```
7. kubelet restart
```
sudo systemctl daemon-reload
sudo systemctl restart kubelet
```
9. console에서 uncordon 으로 활성화 하기

sudo kubectl uncordon node_name
