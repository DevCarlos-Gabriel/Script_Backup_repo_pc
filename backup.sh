#!/bin/bash

GITHUB_TOKEN="user_token"

BACKUP_DIR="Backups_repo_pc"

BACKUP_DIR_REPO="Backups_repo_pc/repo"

BACKUP_DIR_PC="Backups_repo_pc/pc"


mkdir -p ~/$BACKUP_DIR

mkdir -p ~/$BACKUP_DIR_REPO

mkdir -p ~/$BACKUP_DIR_PC


cd ~/$BACKUP_DIR_REPO


REPOS=$(curl -s -H "Authorization: token $GITHUB_TOKEN" "https://api.github.com/user/repos?per_page=100" | jq -r '.[].ssh_url')

for REPO in $REPOS; do
  REPO_NAME=$(basename $REPO .git)
  if [ -d "$REPO_NAME" ]; then
    cd $REPO_NAME
    git pull
    cd ..
  else
    git clone $REPO
  fi
done


cd ..

cd ~/$BACKUP_DIR_PC

HOME_PATH="/home/*/"

rsync -uvac --exclude='.*' --exclude='*.log' --exclude='*.tmp' --exclude='Modelos/' \
          --exclude='Sync/' --exclude='Público/' --exclude='Música/' --exclude='Área de Trabalho/' --exclude='Backups_repo_pc/' $HOME_PATH ~/$BACKUP_DIR_PC

echo "





"

echo "Seus arquivos foram salvos no diretório ~/Backups_repo_pc"

# Beta 0.0.2