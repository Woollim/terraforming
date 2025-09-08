#!/usr/bin/env bash
set -euo pipefail

BREWFILE="./Brewfile"

echo "🍺 Homebrew 설치 및 패키지 설치를 시작합니다..."

# -------------------------------
# 1. Homebrew 설치
# -------------------------------
echo "==> Homebrew 확인/설치"
if ! command -v brew >/dev/null 2>&1; then
  echo " - Homebrew 설치 중..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [[ -d /opt/homebrew/bin ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -d /usr/local/bin ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
  echo " - Homebrew 설치 완료"
else
  echo " - Homebrew 이미 설치됨"
fi

# -------------------------------
# 2. Brewfile 실행
# -------------------------------
if [[ -f "$BREWFILE" ]]; then
  echo "==> Brewfile 실행 중..."
  brew bundle --file="$BREWFILE"
  echo " - Brewfile 설치 완료"
else
  echo "⚠️ Brewfile($BREWFILE)이 없습니다. 건너뜁니다."
fi

echo "✅ Homebrew 설정 완료!"