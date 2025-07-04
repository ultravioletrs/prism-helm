# prism

Prism AI

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| dusan | <dusan.borovcanin@ultraviolet.rs> |  |

## Source Code

* <https://hub.docker.com/u/magistrala>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://argoproj.github.io/argo-helm | argoRollouts(argo-rollouts) | 2.39.1 |
| https://charts.bitnami.com/bitnami | postgresqlbilling(postgresql) | 12.5.6 |
| https://charts.bitnami.com/bitnami | postgresqlspicedb(postgresql) | 12.5.6 |
| https://charts.bitnami.com/bitnami | postgresqlcvmbilling(postgresql) | 12.5.6 |
| https://charts.bitnami.com/bitnami | postgresqldomains(postgresql) | 12.5.6 |
| https://charts.bitnami.com/bitnami | postgresqlbackends(postgresql) | 12.5.6 |
| https://charts.bitnami.com/bitnami | postgresqlamcerts(postgresql) | 12.5.6 |
| https://charts.bitnami.com/bitnami | postgresqlcomputations(postgresql) | 12.5.6 |
| https://charts.bitnami.com/bitnami | postgresqlusers(postgresql) | 12.5.6 |
| https://charts.bitnami.com/bitnami | postgresqlauth(postgresql) | 12.5.6 |
| https://charts.bitnami.com/bitnami | redis-clients(redis) | 19.6.2 |
| https://charts.external-secrets.io/ | externalsecrets(external-secrets) | 0.17.1-rc1 |
| https://fluent.github.io/helm-charts | fluentbit(fluent-bit) | 0.49.0 |
| https://jaegertracing.github.io/helm-charts | jaeger(jaeger) | 3.4.0 |
| https://kubernetes-sigs.github.io/metrics-server | metrics-server(metrics-server) | 3.12.2 |
| https://nats-io.github.io/k8s/helm/charts/ | nats | 1.2.1 |
| https://opensearch-project.github.io/helm-charts | opensearch(opensearch) | 3.0.0 |
| https://opensearch-project.github.io/helm-charts | opensearch-dashboards(opensearch-dashboards) | 3.0.0 |
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
| argocd.enableTraefikConfig | bool | `true` |  |
| argocd.enabled | bool | `true` |  |
| auth.accessTokenDuration | string | `"1h"` |  |
| auth.affinity | object | `{}` |  |
| auth.calloutMethod | string | `"POST"` |  |
| auth.calloutUrls | string | `"auth"` |  |
| auth.grpcPort | int | `8181` |  |
| auth.host | string | `"auth"` |  |
| auth.httpPort | int | `8189` |  |
| auth.image.pullPolicy | string | `"Always"` |  |
| auth.image.pullSecrets[0].name | string | `"ghcr-secret"` |  |
| auth.image.repository | string | `"ghcr.io/ultravioletrs/prism/auth"` |  |
| auth.image.tag | string | `"latest"` |  |
| auth.invitationDuration | string | `"168h"` |  |
| auth.invokePermissions | string | `"create_computation_permission,run_permission,create_cvms_permission,add_role_users_permission"` |  |
| auth.logLevel | string | `"info"` |  |
| auth.nodeSelector | object | `{}` |  |
| auth.refreshTokenDuration | string | `"24h"` |  |
| auth.sslMode | string | `"disable"` |  |
| auth.timeout | string | `"10s"` |  |
| auth.tlsVerification | string | `"false"` |  |
| auth.tolerations | object | `{}` |  |
| backends.cvmsPort | int | `7018` |  |
| backends.grpcPort | int | `7006` |  |
| backends.host | string | `"backends"` |  |
| backends.httpPort | int | `9011` |  |
| backends.image.pullPolicy | string | `"Always"` |  |
| backends.image.pullSecrets[0].name | string | `"ghcr-secret"` |  |
| backends.image.repository | string | `"ghcr.io/ultravioletrs/prism/backends"` |  |
| backends.image.tag | string | `"latest"` |  |
| backends.logLevel | string | `"info"` |  |
| backends.managerSNPGrpcHost | string | `"109.92.195.153"` |  |
| backends.managerSNPGrpcPort | int | `6101` |  |
| backends.managerTDXGrpcHost | string | `"109.92.195.153"` |  |
| backends.managerTDXGrpcPort | int | `49201` |  |
| billing.enabled | bool | `true` |  |
| billing.grpcPort | int | `7022` |  |
| billing.host | string | `"billing"` |  |
| billing.httpPort | int | `9022` |  |
| billing.image.pullPolicy | string | `"Always"` |  |
| billing.image.pullSecrets[0].name | string | `"ghcr-secret"` |  |
| billing.image.repository | string | `"ghcr.io/absmach/amdm/billing"` |  |
| billing.image.tag | string | `"prism-latest"` |  |
| billing.logLevel | string | `"info"` |  |
| callouts.method | string | `"POST"` |  |
| callouts.operations.prism | string | `"create_computation,run_computation,create_cvm"` |  |
| callouts.operations.smqdomains | string | `"oPAcceptInvitation,OpRoleAddMembers,OpDisableDomain"` |  |
| certs.grpcPort | int | `7008` |  |
| certs.host | string | `"certs"` |  |
| certs.httpPort | int | `8090` |  |
| certs.image.pullPolicy | string | `"Always"` |  |
| certs.image.pullSecrets[0].name | string | `"ghcr-secret"` |  |
| certs.image.repository | string | `"ghcr.io/ultravioletrs/prism/certs"` |  |
| certs.image.tag | string | `"latest"` |  |
| certs.logLevel | string | `"info"` |  |
| computations.host | string | `"computations"` |  |
| computations.httpPort | int | `9000` |  |
| computations.image.pullPolicy | string | `"Always"` |  |
| computations.image.pullSecrets[0].name | string | `"ghcr-secret"` |  |
| computations.image.repository | string | `"ghcr.io/ultravioletrs/prism/computations"` |  |
| computations.image.tag | string | `"latest"` |  |
| computations.logLevel | string | `"info"` |  |
| cvmbilling.enabled | bool | `true` |  |
| cvmbilling.grpcPort | int | `7022` |  |
| cvmbilling.host | string | `"billing"` |  |
| cvmbilling.httpPort | int | `9022` |  |
| cvmbilling.image.pullPolicy | string | `"Always"` |  |
| cvmbilling.image.pullSecrets[0].name | string | `"ghcr-secret"` |  |
| cvmbilling.image.repository | string | `"ghcr.io/ultravioletrs/prism/cvm-billing"` |  |
| cvmbilling.image.tag | string | `"latest"` |  |
| cvmbilling.logLevel | string | `"info"` |  |
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
| deployments[8] | string | `"cvm-billing"` |  |
| domains.grpcPort | int | `7013` |  |
| domains.host | string | `"domains"` |  |
| domains.httpPort | int | `9013` |  |
| domains.image.pullPolicy | string | `"Always"` |  |
| domains.image.pullSecrets[0].name | string | `"ghcr-secret"` |  |
| domains.image.repository | string | `"supermq/domains"` |  |
| domains.image.tag | string | `"latest"` |  |
| domains.jaegerTraceRatio | float | `1` |  |
| domains.logLevel | string | `"info"` |  |
| domains.redisTCPPort | int | `6379` |  |
| domains.redisUrl | string | `"redis://domains-redis-master:6379/0"` |  |
| domains.sendTelemetry | bool | `false` |  |
| env.prod | bool | `false` |  |
| externalsecrets.defaultRefresh | string | `"1h"` |  |
| externalsecrets.enabled | bool | `false` |  |
| externalsecrets.installCRDs | bool | `true` |  |
| fluentbit.config.customParsers | string | `"[PARSER]\n    Name          json_log\n    Format        json\n    Time_Key      time\n    Time_Format   %Y-%m-%dT%H:%M:%S.%N%z\n"` |  |
| fluentbit.config.filters | string | `"[FILTER]\n    Name      kubernetes\n    Match     *\n    Merge_Log On\n    Keep_Log  Off\n[FILTER]\n    Name          parser\n    Match         *\n    Key_Name      log\n    Parser        json_log\n    Reserve_Data On\n[FILTER]\n    Name          modify\n    Match         *\n    Condition     Key_Exists level\n    Remove        log\n"` |  |
| fluentbit.config.inputs | string | `"[INPUT]\n    Name              tail\n    Path              /var/log/containers/*.log\n    Tag               kube.*\n    Parser            cri\n    DB                /var/log/flb_kube.db\n    Refresh_Interval  5\n    Rotate_Wait       30\n    Mem_Buf_Limit     50MB\n    Skip_Long_Lines   On\n"` |  |
| fluentbit.config.outputs | string | `"[OUTPUT]\n    Name                  opensearch\n    Match                 *\n    Host                  opensearch-cluster-master\n    Port                  9200\n    HTTP_User             admin\n    HTTP_Passwd           admin\n    Index                 prism-logs\n    Type                  _doc\n    Logstash_Format       On\n    Logstash_Prefix       prism-logs\n    Logstash_DateFormat   %Y.%m.%d\n    Suppress_Type_Name    On\n    Buffer_Size           2MB\n    Replace_Dots          On\n    Retry_Limit           False\n    tls                   Off\n    tls.verify            Off\n"` |  |
| fluentbit.config.service | string | `"[SERVICE]\n    Flush         5\n    Log_Level     info\n    Daemon        off\n    Parsers_File  /fluent-bit/etc/parsers.conf\n    Parsers_File  /fluent-bit/etc/conf/custom_parsers.conf\n    HTTP_Server   On\n    HTTP_Listen   0.0.0.0\n    HTTP_Port     2020\n"` |  |
| fluentbit.enabled | bool | `true` |  |
| fluentbit.kind | string | `"DaemonSet"` |  |
| fluentbit.rbac.create | bool | `true` |  |
| fluentbit.resources.limits.cpu | string | `"200m"` |  |
| fluentbit.resources.limits.memory | string | `"256Mi"` |  |
| fluentbit.resources.requests.cpu | string | `"100m"` |  |
| fluentbit.resources.requests.memory | string | `"128Mi"` |  |
| fluentbit.serviceAccount.create | bool | `true` |  |
| fluentbit.serviceAccount.name | string | `"prism-fluent-bit-sa"` |  |
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
| opensearch-dashboards.config."opensearch_dashboards.yml" | string | `"server.basePath: \"/opensearch\"\nserver.rewriteBasePath: true\nserver.host: \"0.0.0.0\"\nopensearch.ssl.verificationMode: none\nopensearch_security.enabled: false\nopensearch_security.multitenancy.enabled: false\n"` |  |
| opensearch-dashboards.config.opensearch.verificationMode | string | `"none"` |  |
| opensearch-dashboards.config.ssl.enabled | bool | `false` |  |
| opensearch-dashboards.enabled | bool | `true` |  |
| opensearch-dashboards.fullnameOverride | string | `"prism-opensearch-dashboards"` |  |
| opensearch-dashboards.opensearchHosts | string | `"http://opensearch-cluster-master:9200"` |  |
| opensearch-dashboards.replicaCount | int | `1` |  |
| opensearch-dashboards.resources.limits.cpu | string | `"1"` |  |
| opensearch-dashboards.resources.limits.memory | string | `"1Gi"` |  |
| opensearch-dashboards.resources.requests.cpu | string | `"300m"` |  |
| opensearch-dashboards.resources.requests.memory | string | `"512Mi"` |  |
| opensearch-dashboards.service.port | int | `5601` |  |
| opensearch-dashboards.service.type | string | `"ClusterIP"` |  |
| opensearch.clusterName | string | `"prism-opensearch-cluster"` |  |
| opensearch.config."opensearch.yml" | string | `"cluster.name: \"prism-opensearch-cluster\"\nnode.name: \"prism-opensearch-cluster-master-0\"\nnetwork.host: \"0.0.0.0\"\ndiscovery.type: \"single-node\"\nplugins.security.disabled: true\nbootstrap.memory_lock: false\nindices.query.bool.max_clause_count: 1024\n"` |  |
| opensearch.enabled | bool | `true` |  |
| opensearch.extraEnvs[0].name | string | `"OPENSEARCH_INITIAL_ADMIN_PASSWORD"` |  |
| opensearch.extraEnvs[0].value | string | `";52PWP4E3m&kTsgw"` |  |
| opensearch.extraEnvs[1].name | string | `"DISABLE_SECURITY_PLUGIN"` |  |
| opensearch.extraEnvs[1].value | string | `"true"` |  |
| opensearch.extraEnvs[2].name | string | `"DISABLE_INSTALL_DEMO_CONFIG"` |  |
| opensearch.extraEnvs[2].value | string | `"true"` |  |
| opensearch.nodeGroup | string | `"master"` |  |
| opensearch.opensearchJavaOpts | string | `"-Xms1g -Xmx1g"` |  |
| opensearch.persistence.enabled | bool | `true` |  |
| opensearch.persistence.size | string | `"20Gi"` |  |
| opensearch.replicas | int | `1` |  |
| opensearch.resources.limits.cpu | string | `"2"` |  |
| opensearch.resources.limits.memory | string | `"4Gi"` |  |
| opensearch.resources.requests.cpu | string | `"300m"` |  |
| opensearch.resources.requests.memory | string | `"512Mi"` |  |
| opensearch.roles[0] | string | `"cluster_manager"` |  |
| opensearch.roles[1] | string | `"data"` |  |
| opensearch.roles[2] | string | `"ingest"` |  |
| opensearch.security.enabled | bool | `false` |  |
| opensearch.singleNode | bool | `true` |  |
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
| postgresqlcvmbilling.database | string | `"cvm-billing-db"` |  |
| postgresqlcvmbilling.enabled | bool | `true` |  |
| postgresqlcvmbilling.global.postgresql.auth.database | string | `"cvm-billing-db"` |  |
| postgresqlcvmbilling.global.postgresql.auth.existingSecret | string | `"prism-cvm-billing-secrets"` |  |
| postgresqlcvmbilling.global.postgresql.auth.secretKeys.adminPasswordKey | string | `"PRISM_CVM_BILLING_DB_PASS"` |  |
| postgresqlcvmbilling.global.postgresql.auth.secretKeys.userPasswordKey | string | `"PRISM_CVM_BILLING_DB_PASS"` |  |
| postgresqlcvmbilling.global.postgresql.auth.username | string | `"prism"` |  |
| postgresqlcvmbilling.global.postgresql.service.ports.postgresql | int | `5432` |  |
| postgresqlcvmbilling.host | string | `"postgresql-cvm-billing"` |  |
| postgresqlcvmbilling.name | string | `"postgresql-cvm-billing"` |  |
| postgresqlcvmbilling.port | int | `5432` |  |
| postgresqlcvmbilling.primary.resources.limits.cpu | string | `"250m"` |  |
| postgresqlcvmbilling.primary.resources.limits.memory | string | `"256Mi"` |  |
| postgresqlcvmbilling.primary.resources.requests.cpu | string | `"125m"` |  |
| postgresqlcvmbilling.primary.resources.requests.memory | string | `"128Mi"` |  |
| postgresqlcvmbilling.primary.resourcesPreset | string | `""` |  |
| postgresqlcvmbilling.username | string | `"prism"` |  |
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
| postgresqlusers.global.postgresql.auth.existingSecret | string | `"prism-users-secrets"` |  |
| postgresqlusers.global.postgresql.auth.secretKeys.adminPasswordKey | string | `"SMQ_USERS_DB_PASS"` |  |
| postgresqlusers.global.postgresql.auth.secretKeys.userPasswordKey | string | `"SMQ_USERS_DB_PASS"` |  |
| postgresqlusers.global.postgresql.auth.username | string | `"prism"` |  |
| postgresqlusers.global.postgresql.service.ports.postgresql | int | `5432` |  |
| postgresqlusers.host | string | `"postgresql-users"` |  |
| postgresqlusers.name | string | `"postgresql-users"` |  |
| postgresqlusers.port | int | `5432` |  |
| postgresqlusers.primary.resources.limits.cpu | string | `"250m"` |  |
| postgresqlusers.primary.resources.limits.memory | string | `"256Mi"` |  |
| postgresqlusers.primary.resources.requests.cpu | string | `"125m"` |  |
| postgresqlusers.primary.resources.requests.memory | string | `"128Mi"` |  |
| postgresqlusers.primary.resourcesPreset | string | `""` |  |
| postgresqlusers.username | string | `"prism"` |  |
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
| prometheus.grafana."grafana.ini"."auth.ldap".allow_sign_up | bool | `false` |  |
| prometheus.grafana."grafana.ini"."auth.ldap".enabled | bool | `false` |  |
| prometheus.grafana."grafana.ini".server.root_url | string | `"https://staging.prism.ultraviolet.rs/grafana"` |  |
| prometheus.grafana."grafana.ini".server.serve_from_sub_path | bool | `false` |  |
| prometheus.grafana.admin.existingSecret | string | `"prism-prometheus-secrets"` |  |
| prometheus.grafana.admin.passwordKey | string | `"GRAFANA_ADMIN_PASSWORD"` |  |
| prometheus.grafana.admin.userKey | string | `"GRAFANA_ADMIN_USER"` |  |
| prometheus.grafana.ingress.enabled | bool | `false` |  |
| prometheus.grafana.sidecar.dashboards.enabled | bool | `true` |  |
| prometheus.grafana.sidecar.dashboards.label | string | `"grafana_dashboard"` |  |
| prometheus.grafana.sidecar.dashboards.labelValue | string | `"1"` |  |
| prometheus.grafana.sidecar.dashboards.searchNamespace | string | `"ALL"` |  |
| prometheus.kubeStateMetrics.enabled | bool | `true` |  |
| prometheus.nodeExporter.enabled | bool | `true` |  |
| prometheus.prometheus.prometheusSpec.additionalScrapeConfigs[0].job_name | string | `"prism"` |  |
| prometheus.prometheus.prometheusSpec.additionalScrapeConfigs[0].kubernetes_sd_configs[0].role | string | `"pod"` |  |
| prometheus.prometheus.prometheusSpec.additionalScrapeConfigs[0].relabel_configs[0].action | string | `"keep"` |  |
| prometheus.prometheus.prometheusSpec.additionalScrapeConfigs[0].relabel_configs[0].regex | bool | `true` |  |
| prometheus.prometheus.prometheusSpec.additionalScrapeConfigs[0].relabel_configs[0].source_labels[0] | string | `"__meta_kubernetes_pod_annotation_prometheus_io_scrape"` |  |
| prometheus.prometheus.prometheusSpec.additionalScrapeConfigs[0].relabel_configs[1].action | string | `"replace"` |  |
| prometheus.prometheus.prometheusSpec.additionalScrapeConfigs[0].relabel_configs[1].regex | string | `"(.+)"` |  |
| prometheus.prometheus.prometheusSpec.additionalScrapeConfigs[0].relabel_configs[1].source_labels[0] | string | `"__meta_kubernetes_pod_annotation_prometheus_io_path"` |  |
| prometheus.prometheus.prometheusSpec.additionalScrapeConfigs[0].relabel_configs[1].target_label | string | `"__metrics_path__"` |  |
| prometheus.prometheus.prometheusSpec.additionalScrapeConfigs[0].relabel_configs[2].action | string | `"replace"` |  |
| prometheus.prometheus.prometheusSpec.additionalScrapeConfigs[0].relabel_configs[2].regex | string | `"([^:]+):(\\d+);(\\d+)"` |  |
| prometheus.prometheus.prometheusSpec.additionalScrapeConfigs[0].relabel_configs[2].replacement | string | `"${1}:${3}"` |  |
| prometheus.prometheus.prometheusSpec.additionalScrapeConfigs[0].relabel_configs[2].source_labels[0] | string | `"__address__"` |  |
| prometheus.prometheus.prometheusSpec.additionalScrapeConfigs[0].relabel_configs[2].source_labels[1] | string | `"__meta_kubernetes_pod_annotation_prometheus_io_port"` |  |
| prometheus.prometheus.prometheusSpec.additionalScrapeConfigs[0].relabel_configs[2].target_label | string | `"__address__"` |  |
| prometheus.prometheus.prometheusSpec.additionalScrapeConfigs[0].relabel_configs[3].action | string | `"keep"` |  |
| prometheus.prometheus.prometheusSpec.additionalScrapeConfigs[0].relabel_configs[3].regex | string | `"prism-staging;.*"` |  |
| prometheus.prometheus.prometheusSpec.additionalScrapeConfigs[0].relabel_configs[3].source_labels[0] | string | `"__meta_kubernetes_pod_label_app"` |  |
| prometheus.prometheus.prometheusSpec.additionalScrapeConfigs[0].relabel_configs[3].source_labels[1] | string | `"__meta_kubernetes_pod_label_component"` |  |
| prometheus.prometheus.prometheusSpec.additionalScrapeConfigs[0].relabel_configs[4].action | string | `"replace"` |  |
| prometheus.prometheus.prometheusSpec.additionalScrapeConfigs[0].relabel_configs[4].regex | string | `"([^;]+);(.*)"` |  |
| prometheus.prometheus.prometheusSpec.additionalScrapeConfigs[0].relabel_configs[4].replacement | string | `"${1}_${2}"` |  |
| prometheus.prometheus.prometheusSpec.additionalScrapeConfigs[0].relabel_configs[4].source_labels[0] | string | `"__meta_kubernetes_pod_label_app"` |  |
| prometheus.prometheus.prometheusSpec.additionalScrapeConfigs[0].relabel_configs[4].source_labels[1] | string | `"__meta_kubernetes_pod_label_component"` |  |
| prometheus.prometheus.prometheusSpec.additionalScrapeConfigs[0].relabel_configs[4].target_label | string | `"instance"` |  |
| prometheus.prometheus.prometheusSpec.additionalScrapeConfigs[0].relabel_configs[5].action | string | `"replace"` |  |
| prometheus.prometheus.prometheusSpec.additionalScrapeConfigs[0].relabel_configs[5].source_labels[0] | string | `"__meta_kubernetes_pod_label_app"` |  |
| prometheus.prometheus.prometheusSpec.additionalScrapeConfigs[0].relabel_configs[5].target_label | string | `"service_name"` |  |
| prometheus.prometheus.prometheusSpec.additionalScrapeConfigs[0].relabel_configs[6].action | string | `"replace"` |  |
| prometheus.prometheus.prometheusSpec.additionalScrapeConfigs[0].relabel_configs[6].regex | string | `"(.*)"` |  |
| prometheus.prometheus.prometheusSpec.additionalScrapeConfigs[0].relabel_configs[6].replacement | string | `"${1}"` |  |
| prometheus.prometheus.prometheusSpec.additionalScrapeConfigs[0].relabel_configs[6].source_labels[0] | string | `"__meta_kubernetes_pod_label_component"` |  |
| prometheus.prometheus.prometheusSpec.additionalScrapeConfigs[0].relabel_configs[6].target_label | string | `"component"` |  |
| prometheus.prometheus.prometheusSpec.additionalScrapeConfigs[0].relabel_configs[7].action | string | `"replace"` |  |
| prometheus.prometheus.prometheusSpec.additionalScrapeConfigs[0].relabel_configs[7].source_labels[0] | string | `"__meta_kubernetes_namespace"` |  |
| prometheus.prometheus.prometheusSpec.additionalScrapeConfigs[0].relabel_configs[7].target_label | string | `"namespace"` |  |
| prometheus.prometheus.prometheusSpec.additionalScrapeConfigs[0].relabel_configs[8].action | string | `"replace"` |  |
| prometheus.prometheus.prometheusSpec.additionalScrapeConfigs[0].relabel_configs[8].source_labels[0] | string | `"__meta_kubernetes_pod_name"` |  |
| prometheus.prometheus.prometheusSpec.additionalScrapeConfigs[0].relabel_configs[8].target_label | string | `"pod_name"` |  |
| prometheus.prometheus.prometheusSpec.replicas | int | `1` |  |
| prometheus.prometheus.prometheusSpec.retention | string | `"5d"` |  |
| redis-clients.auth.enabled | bool | `false` |  |
| redis-clients.fullnameOverride | string | `"domains-redis"` |  |
| redis-clients.replica.replicaCount | int | `1` |  |
| redis-clients.volumePermissions.enabled | bool | `true` |  |
| spicedb.affinity | object | `{}` |  |
| spicedb.datastore.engine | string | `"postgres"` |  |
| spicedb.dispatch.enabled | bool | `false` |  |
| spicedb.dispatch.port | int | `50053` |  |
| spicedb.grpc.port | int | `50051` |  |
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
| ui.billingUrl | string | `"http://billing:9022"` |  |
| ui.computationsPathPrefix | string | `"/computations"` |  |
| ui.domainsUrl | string | `"http://auth:8189"` |  |
| ui.httpPort | int | `9095` |  |
| ui.image.pullPolicy | string | `"Always"` |  |
| ui.image.pullSecrets[0].name | string | `"ghcr-secret"` |  |
| ui.image.repository | string | `"ghcr.io/ultravioletrs/prism/ui"` |  |
| ui.image.tag | string | `"latest"` |  |
| ui.instanceId | string | `""` |  |
| ui.logLevel | string | `"debug"` |  |
| ui.pathPrefix | string | `"/ui"` |  |
| ui.returnUrl | string | `"/ui/payment-success"` |  |
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
| users.jaegerTraceRatio | float | `1` |  |
| users.logLevel | string | `"info"` |  |
| users.mgGrpcPort | int | `7005` |  |
| users.passwordRegex | string | `"^.{8,}$"` |  |
| users.secretKey | string | `"secretKey"` |  |
| users.sendTelemetry | bool | `false` |  |
| users.tokenResetEndpoint | string | `"/reset-request"` |  |
