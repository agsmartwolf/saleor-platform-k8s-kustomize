.PHONY: build apply diff superuser delete dry-apply dry-delete

build:
	mkctl kustomize build .

apply:
	mkctl kustomize build . | kubectl apply -f -

diff:
	mkctl kustomize build . | kubectl diff -f -

superuser:
	POD=$$(kubectl get pods -n saleor | grep -v -E 'mailhog|jaeger|db|redis|checkout|dashboard|storefront|worker' | tail -n 1 | cut -d ' ' -f 1); kubectl exec -i -t $${POD} -c saleor-api -n saleor -- python manage.py createsuperuser

sendtestemail:
	POD=$$(kubectl get pods -n saleor | grep -v -E 'mailhog|jaeger|db|redis|checkout|dashboard|storefront|worker' | tail -n 1 | cut -d ' ' -f 1); kubectl exec -i -t $${POD} -c saleor-api -n saleor -- python manage.py sendtestemail --admin

delete:
	mkctl kustomize build . | kubectl delete -f -

dry-apply:
	mkctl kustomize build . | kubectl apply -f - --dry-run=client

dry-delete:
	mkctl kustomize build . | kubectl delete -f - --dry-run=client
