.PHONY: build apply diff superuser delete dry-apply dry-delete

build:
	mkctl kustomize build .

apply:
	mkctl kustomize build . | mkctl apply -f -

diff:
	mkctl kustomize build . | mkctl diff -f -

superuser:
	POD=$$(mkctl get pods -n saleor | grep -v -E 'mailhog|jaeger|db|redis|checkout|dashboard|storefront|worker' | tail -n 1 | cut -d ' ' -f 1); mkctl exec -i -t $${POD} -c saleor-api -n saleor -- python manage.py createsuperuser

sendtestemail:
	POD=$$(mkctl get pods -n saleor | grep -v -E 'mailhog|jaeger|db|redis|checkout|dashboard|storefront|worker' | tail -n 1 | cut -d ' ' -f 1); mkctl exec -i -t $${POD} -c saleor-api -n saleor -- python manage.py sendtestemail --admin

delete:
	mkctl kustomize build . | mkctl delete -f -

dry-apply:
	mkctl kustomize build . | mkctl apply -f - --dry-run=client

dry-delete:
	mkctl kustomize build . | mkctl delete -f - --dry-run=client
