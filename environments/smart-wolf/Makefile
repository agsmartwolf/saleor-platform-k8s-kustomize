.PHONY: build apply diff superuser delete dry-apply dry-delete

build:
	microk8s kubectl kustomize .

apply:
	microk8s kubectl kustomize . | microk8s kubectl apply -f -

diff:
	microk8s kubectl kustomize . | microk8s kubectl diff -f -

superuser:
	POD=$$(microk8s kubectl get pods -n saleor | grep -v -E 'mailhog|jaeger|db|redis|checkout|dashboard|storefront|worker' | tail -n 1 | cut -d ' ' -f 1); microk8s kubectl exec -i -t $${POD} -c saleor-api -n saleor -- python manage.py createsuperuser

sendtestemail:
	POD=$$(microk8s kubectl get pods -n saleor | grep -v -E 'mailhog|jaeger|db|redis|checkout|dashboard|storefront|worker' | tail -n 1 | cut -d ' ' -f 1); microk8s kubectl exec -i -t $${POD} -c saleor-api -n saleor -- python manage.py sendtestemail --admin

delete:
	microk8s kubectl kustomize . | microk8s kubectl delete -f -

dry-apply:
	microk8s kubectl kustomize . | microk8s kubectl apply -f - --dry-run=client

dry-delete:
	microk8s kubectl kustomize . | microk8s kubectl delete -f - --dry-run=client
