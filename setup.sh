#!/usr/bin/env bash
set -euo pipefail

echo "🚀 macOS 개발 환경 설정을 시작합니다..."

# 논리적 순서에 따른 스크립트 실행 순서
SCRIPTS=(
  "./setup_brew.sh"
  "./setup_zsh.sh"
  "./install_zsh_plugin.sh"
  "./clone_zshrc.sh"
  "./setup_git.sh"
  "./install_dozer.sh"
)

echo "다음 스크립트들을 순서대로 실행합니다:"
for script in "${SCRIPTS[@]}"; do
  if [[ -f "$script" ]]; then
    echo "  - $script"
  else
    echo "  - $script (파일 없음 - 건너뛸 예정)"
  fi
done
echo ""

# 각 스크립트를 순서대로 실행
for script in "${SCRIPTS[@]}"; do
  if [[ -f "$script" ]]; then
    echo "========================================="
    echo "🔄 $script 실행 중..."
    echo "========================================="
    
    if [[ -x "$script" ]]; then
      "$script"
      echo "✅ $script 완료"
    else
      echo "⚠️ $script 실행 권한이 없습니다."
      exit 1
    fi
    
    echo ""
  else
    echo "⚠️ $script 파일이 존재하지 않습니다. 건너뜁니다."
    echo ""
  fi
done

echo "🎉 전체 세팅 완료!"
echo "   - 새 터미널을 열거나 변경사항을 적용하세요."
