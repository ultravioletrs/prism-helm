# prism

Prism AI

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

## Maintainers

| Name  | Email                             | Url |
| ----- | --------------------------------- | --- |
| dusan | <dusan.borovcanin@ultraviolet.rs> |     |

## Source Code

- <https://hub.docker.com/u/magistrala>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://argoproj.github.io/argo-helm | argoRollouts(argo-rollouts) | 2.39.1 |
| https://charts.bitnami.com/bitnami | opensearch(opensearch) | 1.6.3 |
| https://charts.bitnami.com/bitnami | postgresqlbillingpermissions(postgresql) | 12.5.6 |
| https://charts.bitnami.com/bitnami | postgresqlusers(postgresql) | 12.5.6 |
| https://charts.bitnami.com/bitnami | postgresqlamcerts(postgresql) | 12.5.6 |
| https://charts.bitnami.com/bitnami | postgresqlbackends(postgresql) | 12.5.6 |
| https://charts.bitnami.com/bitnami | postgresqldomains(postgresql) | 12.5.6 |
| https://charts.bitnami.com/bitnami | postgresqlcomputations(postgresql) | 12.5.6 |
| https://charts.bitnami.com/bitnami | postgresqlbilling(postgresql) | 12.5.6 |
| https://charts.bitnami.com/bitnami | postgresqlspicedb(postgresql) | 12.5.6 |
| https://charts.bitnami.com/bitnami | postgresqlauth(postgresql) | 12.5.6 |
| https://charts.bitnami.com/bitnami | redis-clients(redis) | 19.6.2 |
| https://charts.external-secrets.io/ | externalsecrets(external-secrets) | 0.16.2 |
| https://fluent.github.io/helm-charts | fluentbit(fluent-bit) | 0.48.5 |
| https://jaegertracing.github.io/helm-charts | jaeger | 3.1.1 |
| https://kubernetes-sigs.github.io/metrics-server | metrics-server(metrics-server) | 3.12.2 |
| https://kubernetes.github.io/dashboard/ | k8sdashboard(kubernetes-dashboard) | 7.10.5 |
| https://nats-io.github.io/k8s/helm/charts/ | nats | 1.2.1 |
| https://prometheus-community.github.io/helm-charts | prometheus(kube-prometheus-stack) | 70.0.2 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| amCerts.grpcPort | int | `7012` |  |
| amCerts.host | string | `"am-certs"` |  |
| amCerts.httpPort | int | `9010` |  |
| amCerts.image.pullPolicy | string | `"Always"` |  |
| amCerts.image.pullSecrets[0].name | string | `"ghcr-secret"` |  |
| amCerts.image.repository | string | `"ghcr.io/absmach/certs"` |  |
| amCerts.image.tag | string | `"latest"` |  |
| amCerts.logLevel | string | `"info"` |  |
| amCerts.sslMode | string | `"disable"` |  |
| argoRollouts.controller.extraArgs[0] | string | `"--namespaced"` |  |
| argoRollouts.controller.metrics.enabled | bool | `true` |  |
| argoRollouts.controller.metrics.serviceMonitor.enabled | bool | `false` |  |
| argoRollouts.controller.replicas | int | `1` |  |
| argoRollouts.dashboard.enabled | bool | `true` |  |
| argoRollouts.enabled | bool | `true` |  |
| argoRollouts.fullnameOverride | string | `"argo-rollouts"` |  |
| argoRollouts.installCRDs | bool | `true` |  |
| argoRollouts.keepCRDs | bool | `true` |  |
| auth.accessTokenDuration | string | `"1h"` |  |
| auth.affinity | object | `{}` |  |
| auth.grpcPort | int | `8181` |  |
| auth.host | string | `"auth"` |  |
| auth.httpPort | int | `8189` |  |
| auth.image.pullPolicy | string | `"Always"` |  |
| auth.image.pullSecrets[0].name | string | `"ghcr-secret"` |  |
| auth.image.repository | string | `"ghcr.io/ultravioletrs/prism/auth"` |  |
| auth.image.tag | string | `"v0.2.0"` |  |
| auth.invitationDuration | string | `"168h"` |  |
| auth.logLevel | string | `"info"` |  |
| auth.nodeSelector | object | `{}` |  |
| auth.refreshTokenDuration | string | `"24h"` |  |
| auth.sslMode | string | `"disable"` |  |
| auth.tolerations | object | `{}` |  |
| backends.cvmsPort | int | `7018` |  |
| backends.grpcPort | int | `7006` |  |
| backends.host | string | `"backends"` |  |
| backends.httpPort | int | `9011` |  |
| backends.image.pullPolicy | string | `"Always"` |  |
| backends.image.pullSecrets[0].name | string | `"ghcr-secret"` |  |
| backends.image.repository | string | `"ghcr.io/ultravioletrs/prism/backends"` |  |
| backends.image.tag | string | `"v0.2.0"` |  |
| backends.logLevel | string | `"info"` |  |
| backends.managerGrpcHost | string | `"109.92.195.153"` |  |
| backends.managerGrpcPort | int | `6101` |  |
| billing.enabled | bool | `true` |  |
| billing.grpcPort | int | `7022` |  |
| billing.host | string | `"billing"` |  |
| billing.httpPort | int | `9022` |  |
| billing.image.pullPolicy | string | `"Always"` |  |
| billing.image.pullSecrets[0].name | string | `"ghcr-secret"` |  |
| billing.image.repository | string | `"ghcr.io/absmach/amdm/billing"` |  |
| billing.image.tag | string | `"latest"` |  |
| billing.logLevel | string | `"info"` |  |
| certs.grpcPort | int | `7008` |  |
| certs.host | string | `"certs"` |  |
| certs.httpPort | int | `8090` |  |
| certs.image.pullPolicy | string | `"Always"` |  |
| certs.image.pullSecrets[0].name | string | `"ghcr-secret"` |  |
| certs.image.repository | string | `"ghcr.io/ultravioletrs/prism/certs"` |  |
| certs.image.tag | string | `"v0.2.0"` |  |
| certs.logLevel | string | `"info"` |  |
| computations.host | string | `"computations"` |  |
| computations.httpPort | int | `9000` |  |
| computations.image.pullPolicy | string | `"Always"` |  |
| computations.image.pullSecrets[0].name | string | `"ghcr-secret"` |  |
| computations.image.repository | string | `"ghcr.io/ultravioletrs/prism/computations"` |  |
| computations.image.tag | string | `"v0.2.0"` |  |
| computations.logLevel | string | `"info"` |  |
| defaults.eventStreamURL | string | `"nats:4222"` |  |
| defaults.image.pullPolicy | string | `"Always"` |  |
| defaults.image.pullSecrets[0].name | string | `"ghcr-secret"` |  |
| defaults.image.rootRepository | string | `"prism"` |  |
| defaults.image.tag | string | `"latest"` |  |
| defaults.jaegerCollectorPort | int | `4318` |  |
| defaults.jaegerTraceRatio | float | `1` |  |
| defaults.logLevel | string | `"info"` |  |
| defaults.natsPort | int | `4222` |  |
| defaults.replicaCount | int | `1` |  |
| defaults.sendTelemetry | bool | `true` |  |
| deployments[0] | string | `"users"` |  |
| deployments[1] | string | `"billing"` |  |
| deployments[2] | string | `"auth"` |  |
| deployments[3] | string | `"certs"` |  |
| deployments[4] | string | `"am-certs"` |  |
| deployments[5] | string | `"computations"` |  |
| deployments[6] | string | `"ui"` |  |
| deployments[7] | string | `"domains"` |  |
| deployments[8] | string | `"traefik"` |  |
| domains.grpcPort | int | `7013` |  |
| domains.host | string | `"domains"` |  |
| domains.httpPort | int | `9013` |  |
| domains.image.pullPolicy | string | `"Always"` |  |
| domains.image.pullSecrets[0].name | string | `"ghcr-secret"` |  |
| domains.image.repository | string | `"ghcr.io/ultravioletrs/prism/workspaces"` |  |
| domains.image.tag | string | `"v0.2.0"` |  |
| domains.logLevel | string | `"info"` |  |
| domains.redisTCPPort | int | `6379` |  |
| domains.redisUrl | string | `"redis://domains-redis-master:6379/0"` |  |
| env.prod | bool | `false` |  |
| externalsecrets.defaultRefresh | string | `"1h"` |  |
| externalsecrets.enabled | bool | `false` |  |
| fluentbit.config.filters | string | `"[FILTER]\n    Name         kubernetes\n    Match        kube.*\n    k8s-logging.exclude off\n    Buffer_Size 2MB\n"` |  |
| fluentbit.config.inputs | string | `"[INPUT]\n    Name             tail\n    Path             /var/log/containers/*.log\n    Read_from_head   true\n    Tag              kube.*\n"` |  |
| fluentbit.config.outputs | string | `"[OUTPUT]\n    Name                  opensearch\n    Match                 kube.*\n    Host                  prism-open-search\n    Port                  9200\n    HTTP_User             admin\n    HTTP_Passwd           admin\n    Index                 prism-logs\n    Type                  _doc\n    Logstash_Format       On\n    Logstash_Prefix       prism-logs\n    Suppress_Type_Name    On\n    Buffer_Size           2MB\n    Replace_Dots          On\n"` |  |
| fluentbit.enabled | bool | `true` |  |
| fluentbit.resourcesPreset | string | `"small"` |  |
| fluentbit.serviceAccount.create | bool | `true` |  |
| jaeger.agent.enabled | bool | `false` |  |
| jaeger.allInOne.enabled | bool | `false` |  |
| jaeger.collector.service.otlp.grpc.name | string | `"otlp-grpc"` |  |
| jaeger.collector.service.otlp.grpc.port | int | `4317` |  |
| jaeger.collector.service.otlp.http.name | string | `"otlp-http"` |  |
| jaeger.collector.service.otlp.http.port | int | `4318` |  |
| jaeger.fullnameOverride | string | `"prism-jaeger"` |  |
| jaeger.provisionDataStore.cassandra | bool | `false` |  |
| jaeger.query.resources.limits.cpu | string | `"500m"` |  |
| jaeger.query.resources.limits.memory | string | `"512Mi"` |  |
| jaeger.query.resources.requests.cpu | string | `"256m"` |  |
| jaeger.query.resources.requests.memory | string | `"128Mi"` |  |
| jaeger.storage.type | string | `"memory"` |  |
| k8sdashboard.app.ingress.enabled | bool | `false` |  |
| k8sdashboard.app.ingress.tls.enabled | bool | `false` |  |
| k8sdashboard.app.mode | string | `"dashboard"` |  |
| k8sdashboard.enabled | bool | `true` |  |
| metrics-server.args[0] | string | `"--kubelet-insecure-tls"` |  |
| nats.config.cluster.enabled | bool | `false` |  |
| nats.config.cluster.replicas | int | `3` |  |
| nats.config.jetstream.enabled | bool | `true` |  |
| nats.config.jetstream.fileStore.enabled | bool | `true` |  |
| nats.config.jetstream.fileStore.pvc.enabled | bool | `true` |  |
| nats.config.jetstream.memoryStore.enabled | bool | `true` |  |
| nats.config.jetstream.memoryStore.maxSize | string | `"2Gi"` |  |
| nats.container.env.GOMEMLIMIT | string | `"7GiB"` |  |
| nats.container.merge.resources.limits.cpu | string | `"250m"` |  |
| nats.container.merge.resources.limits.memory | string | `"512Mi"` |  |
| nats.container.merge.resources.requests.cpu | string | `"125m"` |  |
| nats.container.merge.resources.requests.memory | string | `"128Mi"` |  |
| opensearch.clusterName | string | `"prism-open-search"` |  |
| opensearch.coordinating.metrics.enabled | bool | `true` |  |
| opensearch.coordinating.metrics.serviceMonitor.enabled | bool | `true` |  |
| opensearch.coordinating.replicaCount | int | `1` |  |
| opensearch.dashboards.enabled | bool | `true` |  |
| opensearch.data.metrics.enabled | bool | `true` |  |
| opensearch.data.metrics.serviceMonitor.enabled | bool | `true` |  |
| opensearch.data.replicaCount | int | `1` |  |
| opensearch.enabled | bool | `true` |  |
| opensearch.fullnameOverride | string | `"prism-open-search"` |  |
| opensearch.ingest.metrics.enabled | bool | `true` |  |
| opensearch.ingest.metrics.serviceMonitor.enabled | bool | `true` |  |
| opensearch.ingest.replicaCount | int | `1` |  |
| opensearch.master.metrics.enabled | bool | `true` |  |
| opensearch.master.metrics.serviceMonitor.enabled | bool | `true` |  |
| opensearch.master.replicaCount | int | `1` |  |
| postgresqlamcerts.database | string | `"certs"` |  |
| postgresqlamcerts.enabled | bool | `true` |  |
| postgresqlamcerts.global.postgresql.auth.database | string | `"certs"` |  |
| postgresqlamcerts.global.postgresql.auth.existingSecret | string | `"prism-am-certs-secrets"` |  |
| postgresqlamcerts.global.postgresql.auth.secretKeys.adminPasswordKey | string | `"AM_CERTS_DB_PASS"` |  |
| postgresqlamcerts.global.postgresql.auth.secretKeys.userPasswordKey | string | `"AM_CERTS_DB_PASS"` |  |
| postgresqlamcerts.global.postgresql.auth.username | string | `"prism"` |  |
| postgresqlamcerts.global.postgresql.service.ports.postgresql | int | `5432` |  |
| postgresqlamcerts.host | string | `"postgresql-am-certs"` |  |
| postgresqlamcerts.name | string | `"postgresql-am-certs"` |  |
| postgresqlamcerts.port | int | `5432` |  |
| postgresqlamcerts.primary.resources.limits.cpu | string | `"250m"` |  |
| postgresqlamcerts.primary.resources.limits.memory | string | `"256Mi"` |  |
| postgresqlamcerts.primary.resources.requests.cpu | string | `"125m"` |  |
| postgresqlamcerts.primary.resources.requests.memory | string | `"128Mi"` |  |
| postgresqlamcerts.primary.resourcesPreset | string | `""` |  |
| postgresqlamcerts.username | string | `"prism"` |  |
| postgresqlauth.database | string | `"auth"` |  |
| postgresqlauth.enabled | bool | `true` |  |
| postgresqlauth.global.postgresql.auth.database | string | `"auth"` |  |
| postgresqlauth.global.postgresql.auth.existingSecret | string | `"prism-auth-secrets"` |  |
| postgresqlauth.global.postgresql.auth.secretKeys.adminPasswordKey | string | `"PRISM_AUTH_DB_PASS"` |  |
| postgresqlauth.global.postgresql.auth.secretKeys.userPasswordKey | string | `"PRISM_AUTH_DB_PASS"` |  |
| postgresqlauth.global.postgresql.auth.username | string | `"magistrala"` |  |
| postgresqlauth.global.postgresql.service.ports.postgresql | int | `5432` |  |
| postgresqlauth.host | string | `"postgresql-auth"` |  |
| postgresqlauth.name | string | `"postgresql-auth"` |  |
| postgresqlauth.port | int | `5432` |  |
| postgresqlauth.primary.resources.limits.cpu | string | `"250m"` |  |
| postgresqlauth.primary.resources.limits.memory | string | `"256Mi"` |  |
| postgresqlauth.primary.resources.requests.cpu | string | `"125m"` |  |
| postgresqlauth.primary.resources.requests.memory | string | `"128Mi"` |  |
| postgresqlauth.primary.resourcesPreset | string | `""` |  |
| postgresqlauth.username | string | `"magistrala"` |  |
| postgresqlbackends.database | string | `"backends"` |  |
| postgresqlbackends.enabled | bool | `true` |  |
| postgresqlbackends.global.postgresql.auth.database | string | `"backends"` |  |
| postgresqlbackends.global.postgresql.auth.existingSecret | string | `"prism-backends-secrets"` |  |
| postgresqlbackends.global.postgresql.auth.secretKeys.adminPasswordKey | string | `"PRISM_BACKENDS_DB_PASS"` |  |
| postgresqlbackends.global.postgresql.auth.secretKeys.userPasswordKey | string | `"PRISM_BACKENDS_DB_PASS"` |  |
| postgresqlbackends.global.postgresql.auth.username | string | `"prism"` |  |
| postgresqlbackends.global.postgresql.service.ports.postgresql | int | `5432` |  |
| postgresqlbackends.host | string | `"postgresql-backends"` |  |
| postgresqlbackends.name | string | `"postgresql-backends"` |  |
| postgresqlbackends.port | int | `5432` |  |
| postgresqlbackends.primary.resources.limits.cpu | string | `"250m"` |  |
| postgresqlbackends.primary.resources.limits.memory | string | `"256Mi"` |  |
| postgresqlbackends.primary.resources.requests.cpu | string | `"125m"` |  |
| postgresqlbackends.primary.resources.requests.memory | string | `"128Mi"` |  |
| postgresqlbackends.primary.resourcesPreset | string | `""` |  |
| postgresqlbackends.username | string | `"prism"` |  |
| postgresqlbilling.database | string | `"billing"` |  |
| postgresqlbilling.enabled | bool | `true` |  |
| postgresqlbilling.global.postgresql.auth.database | string | `"billing"` |  |
| postgresqlbilling.global.postgresql.auth.existingSecret | string | `"prism-billing-secrets"` |  |
| postgresqlbilling.global.postgresql.auth.secretKeys.adminPasswordKey | string | `"MG_BILLING_DB_PASS"` |  |
| postgresqlbilling.global.postgresql.auth.secretKeys.userPasswordKey | string | `"MG_BILLING_DB_PASS"` |  |
| postgresqlbilling.global.postgresql.auth.username | string | `"prism"` |  |
| postgresqlbilling.global.postgresql.service.ports.postgresql | int | `5432` |  |
| postgresqlbilling.host | string | `"postgresql-billing"` |  |
| postgresqlbilling.name | string | `"postgresql-billing"` |  |
| postgresqlbilling.port | int | `5432` |  |
| postgresqlbilling.primary.resources.limits.cpu | string | `"250m"` |  |
| postgresqlbilling.primary.resources.limits.memory | string | `"256Mi"` |  |
| postgresqlbilling.primary.resources.requests.cpu | string | `"125m"` |  |
| postgresqlbilling.primary.resources.requests.memory | string | `"128Mi"` |  |
| postgresqlbilling.primary.resourcesPreset | string | `""` |  |
| postgresqlbilling.username | string | `"prism"` |  |
| postgresqlcomputations.database | string | `"computations"` |  |
| postgresqlcomputations.enabled | bool | `true` |  |
| postgresqlcomputations.global.postgresql.auth.database | string | `"computations"` |  |
| postgresqlcomputations.global.postgresql.auth.existingSecret | string | `"prism-computations-secrets"` |  |
| postgresqlcomputations.global.postgresql.auth.secretKeys.adminPasswordKey | string | `"PRISM_COMPUTATIONS_DB_PASS"` |  |
| postgresqlcomputations.global.postgresql.auth.secretKeys.userPasswordKey | string | `"PRISM_COMPUTATIONS_DB_PASS"` |  |
| postgresqlcomputations.global.postgresql.auth.username | string | `"prism"` |  |
| postgresqlcomputations.global.postgresql.service.ports.postgresql | int | `5432` |  |
| postgresqlcomputations.host | string | `"postgresql-computations"` |  |
| postgresqlcomputations.name | string | `"postgresql-computations"` |  |
| postgresqlcomputations.port | int | `5432` |  |
| postgresqlcomputations.primary.resources.limits.cpu | string | `"250m"` |  |
| postgresqlcomputations.primary.resources.limits.memory | string | `"256Mi"` |  |
| postgresqlcomputations.primary.resources.requests.cpu | string | `"125m"` |  |
| postgresqlcomputations.primary.resources.requests.memory | string | `"128Mi"` |  |
| postgresqlcomputations.primary.resourcesPreset | string | `""` |  |
| postgresqlcomputations.username | string | `"prism"` |  |
| postgresqldomains.database | string | `"domains"` |  |
| postgresqldomains.enabled | bool | `true` |  |
| postgresqldomains.global.postgresql.auth.database | string | `"domains"` |  |
| postgresqldomains.global.postgresql.auth.existingSecret | string | `"prism-domains-secrets"` |  |
| postgresqldomains.global.postgresql.auth.secretKeys.adminPasswordKey | string | `"SMQ_DOMAINS_DB_PASS"` |  |
| postgresqldomains.global.postgresql.auth.secretKeys.userPasswordKey | string | `"SMQ_DOMAINS_DB_PASS"` |  |
| postgresqldomains.global.postgresql.auth.username | string | `"prism"` |  |
| postgresqldomains.global.postgresql.service.ports.postgresql | int | `5432` |  |
| postgresqldomains.host | string | `"postgresql-domains"` |  |
| postgresqldomains.name | string | `"postgresql-domains"` |  |
| postgresqldomains.port | int | `5432` |  |
| postgresqldomains.primary.resources.limits.cpu | string | `"250m"` |  |
| postgresqldomains.primary.resources.limits.memory | string | `"256Mi"` |  |
| postgresqldomains.primary.resources.requests.cpu | string | `"125m"` |  |
| postgresqldomains.primary.resources.requests.memory | string | `"128Mi"` |  |
| postgresqldomains.primary.resourcesPreset | string | `""` |  |
| postgresqldomains.username | string | `"prism"` |  |
| postgresqlspicedb.database | string | `"spicedb"` |  |
| postgresqlspicedb.enabled | bool | `true` |  |
| postgresqlspicedb.global.postgresql.auth.database | string | `"spicedb"` |  |
| postgresqlspicedb.global.postgresql.auth.existingSecret | string | `"prism-spicedb-db-secrets"` |  |
| postgresqlspicedb.global.postgresql.auth.secretKeys.adminPasswordKey | string | `"PRISM_SPICEDB_DB_PASS"` |  |
| postgresqlspicedb.global.postgresql.auth.secretKeys.userPasswordKey | string | `"PRISM_SPICEDB_DB_PASS"` |  |
| postgresqlspicedb.global.postgresql.auth.username | string | `"magistrala"` |  |
| postgresqlspicedb.global.postgresql.service.ports.postgresql | int | `5432` |  |
| postgresqlspicedb.host | string | `"postgresql-spicedb"` |  |
| postgresqlspicedb.name | string | `"postgresql-spicedb"` |  |
| postgresqlspicedb.port | int | `5432` |  |
| postgresqlspicedb.primary.resources.limits.cpu | string | `"250m"` |  |
| postgresqlspicedb.primary.resources.limits.memory | string | `"256Mi"` |  |
| postgresqlspicedb.primary.resources.requests.cpu | string | `"125m"` |  |
| postgresqlspicedb.primary.resources.requests.memory | string | `"128Mi"` |  |
| postgresqlspicedb.primary.resourcesPreset | string | `""` |  |
| postgresqlspicedb.username | string | `"magistrala"` |  |
| postgresqlusers.database | string | `"users"` |  |
| postgresqlusers.enabled | bool | `true` |  |
| postgresqlusers.global.postgresql.auth.database | string | `"users"` |  |
| postgresqlusers.global.postgresql.auth.existingSecret | string | `"prism-am-users-secrets"` |  |
| postgresqlusers.global.postgresql.auth.secretKeys.adminPasswordKey | string | `"AM_CERTS_DB_PASS"` |  |
| postgresqlusers.global.postgresql.auth.secretKeys.userPasswordKey | string | `"AM_CERTS_DB_PASS"` |  |
| postgresqlusers.global.postgresql.auth.username | string | `"magistrala"` |  |
| postgresqlusers.global.postgresql.service.ports.postgresql | int | `5432` |  |
| postgresqlusers.host | string | `"postgresql-users"` |  |
| postgresqlusers.name | string | `"postgresql-users"` |  |
| postgresqlusers.port | int | `5432` |  |
| postgresqlusers.primary.resources.limits.cpu | string | `"250m"` |  |
| postgresqlusers.primary.resources.limits.memory | string | `"256Mi"` |  |
| postgresqlusers.primary.resources.requests.cpu | string | `"125m"` |  |
| postgresqlusers.primary.resources.requests.memory | string | `"128Mi"` |  |
| postgresqlusers.primary.resourcesPreset | string | `""` |  |
| postgresqlusers.username | string | `"magistrala"` |  |
| prometheus.alertmanager.config.global.resolve_timeout | string | `"5m"` |  |
| prometheus.alertmanager.config.receivers[0].name | string | `"slack_notifications"` |  |
| prometheus.alertmanager.config.receivers[0].slack_configs[0].Channel | string | `"prism-staging"` |  |
| prometheus.alertmanager.config.receivers[0].slack_configs[0].api_url | string | `"https://hooks.slack.com/services/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"` |  |
| prometheus.alertmanager.config.receivers[1].name | string | `"null"` |  |
| prometheus.alertmanager.config.route.group_by[0] | string | `"namespace"` |  |
| prometheus.alertmanager.config.route.group_by[1] | string | `"alertname"` |  |
| prometheus.alertmanager.config.route.group_by[2] | string | `"pod"` |  |
| prometheus.alertmanager.config.route.group_interval | string | `"5m"` |  |
| prometheus.alertmanager.config.route.group_wait | string | `"30s"` |  |
| prometheus.alertmanager.config.route.receiver | string | `"slack_notifications"` |  |
| prometheus.alertmanager.config.route.repeat_interval | string | `"12h"` |  |
| prometheus.alertmanager.config.route.routes[0].group_wait | string | `"10s"` |  |
| prometheus.alertmanager.config.route.routes[0].match.severity | string | `"warning"` |  |
| prometheus.alertmanager.config.route.routes[0].receiver | string | `"slack_notifications"` |  |
| prometheus.alertmanager.config.route.routes[0].repeat_interval | string | `"1m"` |  |
| prometheus.alertmanager.enabled | bool | `true` |  |
| prometheus.alertmanager.persistence.size | string | `"2Gi"` |  |
| prometheus.crds.enabled | bool | `true` |  |
| prometheus.crds.upgradeJob.enabled | bool | `true` |  |
| prometheus.enabled | bool | `true` |  |
| prometheus.fullnameOverride | string | `"prism-monitoring-stack"` |  |
| prometheus.grafana.adminPassword | string | `"prism"` |  |
| prometheus.grafana.adminUser | string | `"prism"` |  |
| prometheus.kubeStateMetrics.enabled | bool | `true` |  |
| prometheus.nodeExporter.enabled | bool | `true` |  |
| redis-clients.auth.enabled | bool | `false` |  |
| redis-clients.fullnameOverride | string | `"domains-redis"` |  |
| redis-clients.replica.replicaCount | int | `1` |  |
| redis-clients.volumePermissions.enabled | bool | `true` |  |
| spicedb.affinity | object | `{}` |  |
| spicedb.datastore.engine | string | `"postgres"` |  |
| spicedb.dispatch.enabled | bool | `false` |  |
| spicedb.dispatch.port | int | `50053` |  |
| spicedb.grpc.port | int | `50051` |  |
| spicedb.grpc.presharedKey | string | `"12345678"` |  |
| spicedb.host | string | `"spicedb"` |  |
| spicedb.http.enabled | bool | `false` |  |
| spicedb.http.port | int | `8080` |  |
| spicedb.image.pullPolicy | string | `"IfNotPresent"` |  |
| spicedb.image.pullSecrets | object | `{}` |  |
| spicedb.image.repository | string | `"authzed/spicedb"` |  |
| spicedb.image.tag | string | `"latest"` |  |
| spicedb.metrics.enabled | bool | `true` |  |
| spicedb.metrics.port | int | `9090` |  |
| spicedb.nodeSelector | object | `{}` |  |
| spicedb.replicaCount | int | `1` |  |
| spicedb.schemaFile | string | `"/spicedb/schema.zed"` |  |
| spicedb.tolerations | object | `{}` |  |
| traefik.dashboard.enabled | bool | `true` |  |
| traefik.image.pullPolicy | string | `"Always"` |  |
| traefik.image.repository | string | `"traefik"` |  |
| traefik.ports.web.entryPoints[0] | string | `"web"` |  |
| traefik.ports.web.expose | bool | `true` |  |
| traefik.ports.web.port | int | `80` |  |
| traefik.ports.websecure.entryPoints[0] | string | `"websecure"` |  |
| traefik.ports.websecure.expose | bool | `true` |  |
| traefik.ports.websecure.port | int | `443` |  |
| ui.billingUrl | string | `"http://billing:9022"` |  |
| ui.computationsPathPrefix | string | `"/computations"` |  |
| ui.domainsUrl | string | `"http://auth:8189"` |  |
| ui.httpPort | int | `9095` |  |
| ui.image.pullPolicy | string | `"Always"` |  |
| ui.image.pullSecrets[0].name | string | `"ghcr-secret"` |  |
| ui.image.repository | string | `"ghcr.io/ultravioletrs/prism/ui"` |  |
| ui.image.tag | string | `"v0.2.0"` |  |
| ui.instanceId | string | `""` |  |
| ui.logLevel | string | `"debug"` |  |
| ui.pathPrefix | string | `"/ui"` |  |
| users.allowSelfRegister | bool | `true` |  |
| users.deleteAfter | string | `"720h"` |  |
| users.deleteInterval | string | `"24h"` |  |
| users.grpcPort | int | `7005` |  |
| users.host | string | `"users"` |  |
| users.httpPort | int | `9003` |  |
| users.image.pullPolicy | string | `"Always"` |  |
| users.image.pullSecrets[0].name | string | `"ghcr-secret"` |  |
| users.image.repository | string | `"supermq/users"` |  |
| users.image.tag | string | `"latest"` |  |
| users.mgGrpcPort | int | `7005` |  |
| users.passwordRegex | string | `"^.{8,}$"` |  |
| users.secretKey | string | `"secretKey"` |  |
| users.tokenResetEndpoint | string | `"/reset-request"` |  |
