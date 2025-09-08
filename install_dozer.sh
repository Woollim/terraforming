#!/bin/bash

# Dozer DMG 자동 설치 스크립트
DMG_PATH="$(dirname "$0")/Dozer.4.0.0.dmg"

echo "Dozer 설치 시작..."

# DMG 파일 존재 확인
if [ ! -f "$DMG_PATH" ]; then
    echo "오류: $DMG_PATH 파일을 찾을 수 없습니다"
    exit 1
fi

# DMG 마운트
echo "DMG 마운트 중..."
MOUNT_POINT=$(hdiutil attach "$DMG_PATH" -nobrowse -quiet | grep -E '^/dev/' | awk '{print $3}')

if [ -z "$MOUNT_POINT" ]; then
    echo "오류: DMG 마운트 실패"
    exit 1
fi

echo "마운트 위치: $MOUNT_POINT"

# .app 파일 찾기 및 복사
APP_FILE=$(find "$MOUNT_POINT" -name "*.app" -type d | head -1)

if [ -n "$APP_FILE" ]; then
    echo "Dozer 앱 설치 중: $(basename "$APP_FILE")"
    cp -R "$APP_FILE" /Applications/
    echo "✅ 설치 완료: /Applications/$(basename "$APP_FILE")"
else
    echo "❌ .app 파일을 찾을 수 없습니다"
    hdiutil detach "$MOUNT_POINT" -quiet
    exit 1
fi

# DMG 언마운트
echo "DMG 언마운트 중..."
hdiutil detach "$MOUNT_POINT" -quiet

echo "🎉 Dozer 설치가 완료되었습니다!"