# prism

Prism

![Version: 1.0.3](https://img.shields.io/badge/Version-1.0.3-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.12.1](https://img.shields.io/badge/AppVersion-0.12.1-informational?style=flat-square)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| @bitnami | postgresqlbootstrap(postgresql) | 12.5.6 |
| @bitnami | postgresqlinvitations(postgresql) | 12.5.6 |
| @bitnami | postgresqlauth(postgresql) | 12.5.6 |
| @bitnami | postgresqlspicedb(postgresql) | 12.5.6 |
| @bitnami | postgresqlthings(postgresql) | 12.5.6 |
| @bitnami | postgresqlusers(postgresql) | 12.5.6 |
| @bitnami | postgresqlui(postgresql) | 12.5.6 |
| @bitnami | postgresqlcerts(postgresql) | 12.5.6 |
| @bitnami | timescaledb(postgresql) | 12.5.6 |
| @bitnami | postgresqljournal(postgresql) | 12.5.6 |
| @bitnami | redis-things(redis) | 19.6.2 |
| @hashicorp | vault(vault) | 0.28.1 |
| @jaegertracing | jaeger | 3.1.1 |
| @nats | nats | 1.2.1 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| auth.grpcPort | int | `7001` |  |
| defaults.image.pullPolicy | string | `"IfNotPresent"` |  |
| defaults.image.pullSecrets | list | `[]` |  |
| defaults.image.repository | string | `"magistrala/users"` |  |
| defaults.image.tag | string | `"latest"` |  |
| defaults.logLevel | string | `"info"` |  |
| defaults.replicaCount | int | `1` |  |
| postgresqlusers.database | string | `"users"` |  |
| postgresqlusers.enabled | bool | `true` |  |
| postgresqlusers.host | string | `"localhost"` |  |
| postgresqlusers.password | string | `"prism"` |  |
| postgresqlusers.port | int | `5432` |  |
| postgresqlusers.username | string | `"prism"` |  |
| users.adminEmail | string | `"admin@example.com"` |  |
| users.adminPassword | string | `"12345678"` |  |
| users.allowSelfRegister | bool | `true` |  |
| users.dbPort | int | `5432` |  |
| users.deleteAfter | string | `"7d"` |  |
| users.deleteInterval | string | `"24h"` |  |
| users.grpcPort | int | `7001` |  |
| users.httpPort | int | `9002` |  |
| users.passwordRegex | string | `"^[a-zA-Z0-9!@#$%^&*]{8,}$"` |  |
| users.secretKey | string | `"supersecretkey"` |  |
| users.tokenResetEndpoint | string | `"http://example.com/reset"` |  |
