#!/usr/bin/env sh

[ -n "${TRACE+x}" ] && set -x

set -e

installDependencies() {
  ALPINE_VERSION=$(sed -E 's/^([0-9][\.][0-9]*).*/\1/g' /etc/alpine-release)
  # shellcheck disable=SC2154
  echo "https://${artifactory_user}:${artifactory_password}@${artifactory_host}/artifactory/alpine-virtual/v$ALPINE_VERSION/main" > /etc/apk/repositories
  echo "https://${artifactory_user}:${artifactory_password}@${artifactory_host}/artifactory/alpine-virtual/v$ALPINE_VERSION/community" >> /etc/apk/repositories
  apk -Uuv add bash curl groff less openssl yq --allow-untrusted
  curl -fSL "https://github.com/yannh/kubeconform/releases/download/v0.4.12/kubeconform-linux-amd64.tar.gz" | tar -C /usr/local/bin -xvz
  chmod +x /usr/local/bin/kubeconform
}

installGitRemotes() {
  # shellcheck disable=SC2154
  git remote add helm "https://oauth2:${gitlab_api_scope_token}@gitlab.com/stackvista/agent/http-header-injector" || true
  # Depth required for helm change detection
  git fetch --depth 100 helm
}

installDependencies
installGitRemotes