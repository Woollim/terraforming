#!/bin/bash

# Git 설정 스크립트

set -e

echo "🔧 Git 설정을 시작합니다..."

# Git 사용자 정보 설정
echo "Git 사용자 정보를 설정합니다..."
git config --global user.name "Woollim"
git config --global user.email "me@wooll.im"
echo "Git 사용자 이름: Woollim"
echo "Git 사용자 이메일: me@wooll.im"

# Git 기본 설정
echo "Git 기본 설정을 적용합니다..."

# 기본 브랜치를 main으로 설정
git config --global init.defaultBranch main

# 줄바꿈 설정 (macOS)
git config --global core.autocrlf input

# 편집기 설정 (vi 사용)
git config --global core.editor vi

# pull 시 rebase 사용
git config --global pull.rebase true

# push 시 현재 브랜치만 푸시
git config --global push.default simple

# 색상 출력 활성화
git config --global color.ui auto

# 대소문자 구분
git config --global core.ignorecase false

# Git 별칭 설정
echo "유용한 Git 별칭을 설정합니다..."
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 HEAD'
git config --global alias.visual '!gitk'
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

echo "✅ Git 설정이 완료되었습니다!"
echo ""
echo "설정된 내용:"
echo "  - 사용자 이름: Woollim"
echo "  - 사용자 이메일: me@wooll.im"
echo "  - 기본 브랜치: main"
echo "  - Pull 방식: rebase"
echo "  - 유용한 별칭들 (st, co, br, ci, lg 등)"