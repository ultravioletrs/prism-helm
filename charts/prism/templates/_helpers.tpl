{{- define "validateSpiceDBDatastoreEngine" -}}
{{- if and (not (eq . "memory")) (not (eq . "postgres")) -}}
  {{- fail "Invalid value for .Values.spicedb.datastore.engine. Must be 'memory' or 'postgres'." -}}
{{- else -}}
  {{- . -}}
{{- end -}}
{{- end -}}