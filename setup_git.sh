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

# GitHub Personal Access Token 설정
echo ""
echo "🔑 GitHub Personal Access Token 설정"
echo "GitHub에서 생성한 Personal Access Token이 있다면 설정할 수 있습니다."
echo "토큰이 없다면 GitHub > Settings > Developer settings > Personal access tokens에서 생성하세요."
echo ""
read -p "GitHub Personal Access Token을 설정하시겠습니까? (y/N): " setup_token

if [[ $setup_token =~ ^[Yy]$ ]]; then
    echo ""
    echo "⚠️  주의: 토큰은 안전하게 보관되며, 터미널에 표시되지 않습니다."
    read -s -p "GitHub Personal Access Token을 입력하세요: " github_token
    echo ""
    
    if [ -n "$github_token" ]; then
        # Git credential helper 설정
        git config --global credential.helper store
        
        # GitHub 원격 저장소에 대한 인증 정보 저장
        echo "https://$(git config --global user.name):${github_token}@github.com" > ~/.git-credentials
        chmod 600 ~/.git-credentials
        
        echo "✅ GitHub Personal Access Token이 설정되었습니다!"
        echo "   이제 GitHub 저장소에 push/pull 할 때 인증이 자동으로 처리됩니다."
    else
        echo "❌ 토큰이 입력되지 않았습니다. 건너뜁니다."
    fi
else
    echo "GitHub Personal Access Token 설정을 건너뜁니다."
fi

echo ""
echo "✅ Git 설정이 완료되었습니다!"
echo ""
echo "설정된 내용:"
echo "  - 사용자 이름: Woollim"
echo "  - 사용자 이메일: me@wooll.im"
echo "  - 기본 브랜치: main"
echo "  - Pull 방식: rebase"
echo "  - 유용한 별칭들 (st, co, br, ci, lg 등)"