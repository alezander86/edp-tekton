{{/*
Expand the name of the chart.
*/}}
{{- define "edp-tekton.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "edp-tekton.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "edp-tekton.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "edp-tekton.labels" -}}
helm.sh/chart: {{ include "edp-tekton.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Link to use custom sonarqube. Format: http://<service-name>.<sonarqube-namespace>:9000 or http://<ip-address>:9000
*/}}
{{- define "edp-tekton.sonarUrl" -}}
{{ $.Values.global.sonarUrl | default (printf "http://sonar.%s:9000" $.Release.Namespace) }}
{{- end }}

{{/*
Link to use custom nexus. Format: http://<service-name>.<nexus-namespace>:8081 or http://<ip-address>:<port>
*/}}
{{- define "edp-tekton.nexusUrl" -}}
{{ $.Values.global.nexusUrl | default (printf "http://nexus.%s:8081" $.Release.Namespace) }}
{{- end }}
