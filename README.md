# Script de Backup de Repositórios e Arquivos Pessoais 🗃️

Este projeto é um script simples em bash para fazer backup de repositórios do GitHub e arquivos pessoais de um diretório especificado. O script usa a API do GitHub para clonar e atualizar repositórios, e rsync para sincronizar arquivos locais.

# Funcionalidades ✨

- Backup de Repositórios: Clona e atualiza repositórios do GitHub;

- Backup de Arquivos Pessoais: Sincroniza arquivos de um diretório local especificado.

# Como Usar 🚀

1. Clone o repositório:

    ```sh
    git clone https://github.com/SeuUsuario/backup_script.git backup_script
    cd backup_script
    ```

2. Configure o token do GitHub:

- Crie um token de acesso pessoal no GitHub (instruções [aqui](https://docs.github.com/pt/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens)).

- Substitua user_token no script pelo seu token.

3. Execute o script:

    ```sh
    ./backup_script.sh
    ```

# Exemplo de Uso 📋

Ao executar o script, ele irá percorrer todos os repositórios no GitHub associados ao token e fará backup dos mesmos no diretório especificado, juntamente com os arquivos pessoais.

1. Backup de Repositórios:

- O script clona os repositórios do seu GitHub e caso eles sofram atualização o programa automaticamente já atualiza o projeto.

2. Backup de Arquivos Pessoais:

- O script sincroniza arquivos do diretório pessoal, excluindo determinados diretórios e tipos de arquivos.

# Estrutura do Código 📂

    ```sh
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

    echo "Seus arquivos foram salvos no diretório ~/Backups_repo_pc"
    

## O código é estruturado da seguinte forma:

1. Variável GITHUB_TOKEN: Define o token de acesso pessoal do GitHub;
   
2. Variáveis BACKUP_DIR, BACKUP_DIR_REPO, BACKUP_DIR_PC: Definem os diretórios de backup;
  
3. Comandos mkdir -p: Criam os diretórios de backup se não existirem;
   
4. Comando cd: Navega até o diretório de backup dos repositórios;
 
5. Comando curl: Recupera os URLs SSH dos repositórios do GitHub;
   
6. Laço for: Percorre todos os repositórios e os clona ou atualiza;
   
7. Comando rsync: Sincroniza os arquivos do diretório pessoal, excluindo determinados diretórios e tipos de arquivos;
   
8. Mensagem de confirmação: Informa ao usuário que os arquivos foram salvos.

# Considerações Finais 📝

Contribuições são bem-vindas! Sinta-se à vontade para abrir um PR ou relatar problemas.

# Licença 📄

Este projeto está licenciado sob a Licença MIT - veja o arquivo [LICENSE](https://github.com/DevCarlos-Gabriel/Script_Backup_repo_pc/blob/main/LICENSE) para mais detalhes.
