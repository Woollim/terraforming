#!/usr/bin/env zsh

set -e

echo "🚀 zsh, oh-my-zsh, powerlevel10k 설치를 시작합니다..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[정보]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[완료]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[경고]${NC} $1"
}

print_error() {
    echo -e "${RED}[오류]${NC} $1"
}

# Check if zsh is installed
print_status "zsh 설치 확인 중..."
if command -v zsh &> /dev/null; then
    print_success "zsh가 이미 설치되어 있습니다"
else
    print_error "zsh가 설치되지 않았습니다. macOS에서는 기본적으로 설치되어 있어야 합니다."
    exit 1
fi

# Install oh-my-zsh
print_status "oh-my-zsh 설치 중..."
if [ -d "$HOME/.oh-my-zsh" ]; then
    print_warning "oh-my-zsh가 이미 설치되어 있습니다"
else
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    print_success "oh-my-zsh 설치 완료"
fi

# Install powerlevel10k
print_status "powerlevel10k 테마 설치 중..."
P10K_DIR="$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
if [ -d "$P10K_DIR" ]; then
    print_warning "powerlevel10k가 이미 설치되어 있습니다"
else
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
    print_success "powerlevel10k 설치 완료"
fi

# Update .zshrc to use powerlevel10k
print_status ".zshrc 파일에 powerlevel10k 테마 설정 중..."
ZSHRC="$HOME/.zshrc"
if grep -q "ZSH_THEME=\"powerlevel10k/powerlevel10k\"" "$ZSHRC"; then
    print_warning ".zshrc에 powerlevel10k 테마가 이미 설정되어 있습니다"
else
    # Backup original .zshrc
    mkdir -p backup
    cp "$ZSHRC" "backup/zsh.backup.$(date +%Y%m%d_%H%M%S)"
    
    # Update theme in .zshrc
    sed -i.tmp 's/^ZSH_THEME=".*"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' "$ZSHRC"
    rm "$ZSHRC.tmp" 2>/dev/null || true
    
    print_success ".zshrc에 powerlevel10k 테마 설정 완료"
fi

# Change default shell to zsh
print_status "기본 셸을 zsh로 변경 중..."
if [[ "$SHELL" == *"zsh"* ]]; then
    print_warning "zsh가 이미 기본 셸입니다"
else
    print_status "기본 셸을 zsh로 변경합니다 (비밀번호가 필요할 수 있습니다)..."
    chsh -s "$(which zsh)"
    print_success "기본 셸이 zsh로 변경되었습니다"
fi

echo ""
print_success "🎉 설치가 성공적으로 완료되었습니다!"
echo ""
echo "다음 단계:"
echo "1. 터미널을 재시작하거나 다음 명령어를 실행하세요: exec zsh"
echo "2. powerlevel10k를 설정하려면 다음 명령어를 실행하세요: p10k configure"
echo ""
print_warning "참고: 모든 변경사항을 적용하려면 터미널을 재시작해야 할 수 있습니다."