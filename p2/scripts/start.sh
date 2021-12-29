/usr/local/bin/kubectl apply -f ./p2/configs/app2.yaml
/usr/local/bin/kubectl apply -f ./p2/configs/app1.yaml
/usr/local/bin/kubectl apply -f ./p2/configs/app3.yaml
/usr/local/bin/kubectl wait --for=condition=complete job/helm-install-traefik-crd -n kube-system --timeout=500s
/usr/local/bin/kubectl apply -f ./p2/configs/ingress.yaml