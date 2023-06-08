#!/usr/bin/env sh

[ -n "${TRACE+x}" ] && set -x

set -e

installDependencies() {
  apk -Uuv add bash curl groff less openssl yq
  curl -fSL "https://github.com/yannh/kubeconform/releases/download/v0.4.12/kubeconform-linux-amd64.tar.gz" | tar -C /usr/local/bin -xvz
  chmod +x /usr/local/bin/kubeconform
}

installGitRemotes() {
  # shellcheck disable=SC2154
  git remote add helm "https://oauth2:${gitlab_api_scope_token}@gitlab.com/stackvista/agent/http-header-injector" || true
  git fetch helm
}

installDependencies
installGitRemotes