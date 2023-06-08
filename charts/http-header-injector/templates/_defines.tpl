{{- define "http-header-injector.app.name" -}}
{{ .Release.Name }}-http-header-injector
{{- end -}}

{{- define "http-header-injector.webhook-service.name" -}}
{{ .Release.Name }}-http-header-injector
{{- end -}}

{{- define "http-header-injector.webhook-service.fqname" -}}
{{ .Release.Name }}-http-header-injector.{{ .Release.Namespace }}.svc
{{- end -}}

{{- define "http-header-injector.cert-secret.name" -}}
{{ .Release.Name }}-http-injector-cert
{{- end -}}

{{- define "http-header-injector.cert-clusterrole.name" -}}
{{ .Release.Name }}-http-injector-cert-cluster-role
{{- end -}}

{{- define "http-header-injector.cert-serviceaccount.name" -}}
{{ .Release.Name }}-http-injector-cert-sa
{{- end -}}

{{- define "http-header-injector.cert-config.name" -}}
{{ .Release.Name }}-cert-config
{{- end -}}

{{- define "http-header-injector.mutatingwebhookconfiguration.name" -}}
{{ .Release.Name }}-http-header-injector-webhook.stackstate.io
{{- end -}}

{{- define "http-header-injector.webhook-config.name" -}}
{{ .Release.Name }}-http-header-injector-config
{{- end -}}

{{- define "http-header-injector.mutating-webhook.name" -}}
{{ .Release.Name }}-http-header-injector-webhook
{{- end -}}
