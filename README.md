# 🧩 Profile Aggregator

## 📝 DESCRIÇÃO
Aplicação Ruby on Rails Full Stack para indexar perfis do GitHub utilizando Web Scraping, armazenar estatísticas, gerar URLs encurtadas e permitir re-escaneamento manual dos dados.

Projeto desenvolvido como desafio técnico, priorizando arquitetura limpa, testes automatizados e decisões técnicas justificadas.

---

## 🚀 Visão Geral da Arquitetura

- Ruby 3.3.6
- Rails 8.1.1
- Banco de Dados: PostgreSQL
- Testes: RSpec + FactoryBot + Shoulda Matchers
- Containerização: Docker + Docker Compose
- Frontend: Bootstrap 5
- Scraping: Nokogiri + OpenURI
---

## 🧱 Arquitetura da Aplicação

A aplicação segue uma arquitetura orientada a serviços (Service Objects) para manter o código limpo, testável e desacoplado.

## 📁 Estrutura Principal

```text
app/
├── controllers/
├── models/
├── services/
│   ├── github/
│   │   ├── profile_scraper.rb         # Coleta dados do perfil no GitHub
│   │   ├── contributions_scraper.rb   # Coleta contribuições do último ano
│   │   └── profile_importer.rb        # Orquestra importação e persistência
│   └── short_urls/
│       └── generator.rb               # Gera códigos para URLs curtas
├── views/
│   ├── layouts/                       # Layouts principais
│   ├── shared/                        # Partials reutilizáveis
│   ├── home/                          # Views da home (busca)
│   └── profiles/                      # Views de perfil
```

## 🗄️ Estrutura do Banco de Dados (PostgreSQL)

O banco de dados foi modelado para armazenar perfis do GitHub, suas estatísticas
e URLs curtas associadas, garantindo integridade referencial e performance.

### 📌 Tabela: profiles
Armazena os dados principais do perfil.

| Campo | Tipo | Descrição |
|-----|-----|---------|
| id | bigint | Chave primária |
| name | string | Nome do usuário |
| github_username | string | Username do GitHub (único) |
| github_url | string | URL do perfil no GitHub |
| created_at | timestamp | Data de criação |
| updated_at | timestamp | Data de atualização |

---

### 📌 Tabela: profile_stats
Armazena estatísticas do perfil (1:1 com profiles).

| Campo | Tipo | Descrição |
|-----|-----|---------|
| profile_id | bigint | FK para profiles |
| followers_count | integer | Número de seguidores |
| following_count | integer | Número de seguindo |
| stars_count | integer | Estrelas recebidas |
| contributions_last_year | integer | Contribuições no último ano |
| location | string | Localização |
| organization | string | Organização |
| last_scraped_at | timestamp | Última coleta |
| avatar_url | string | Avatar do GitHub |

---

### 📌 Tabela: short_urls
Armazena URLs curtas para compartilhamento.

| Campo | Tipo | Descrição |
|-----|-----|---------|
| profile_id | bigint | FK para profiles |
| code | string | Código único da URL |
| target_url | string | URL original |
| created_at | timestamp | Data de criação |
| updated_at | timestamp | Data de atualização |

---

### 🔗 Relacionamentos
- `profiles` **1:1** `profile_stats`
- `profiles` **1:1** `short_urls`

## 🔍 Fluxo de Funcionamento
1️⃣ Cadastro de Perfil
  - Usuário informa
    - Username do GitHub
    - URL do GitHub

- Controller chama:
```bash
Github::ProfileImporter.new(profile_params[:github_username], profile_params[:github_url]).call
```

2️⃣ Service Object: Github::ProfileImporter
- Responsável por orquestrar todo o processo:
  - Chama ProfileScraper
  - Chama ContributionsScraper
  - Cria ou atualiza Profile
  - Atualiza ProfileStat
  - Gera ShortUrl se não existir

3️⃣ Web Scraping
- Github::ProfileScraper
  - Faz scraping da página pública do GitHub
  
- Extrai:
  - Nome
  - Avatar
  - Followers
  - Following
  - Stars
  - Organização
  - Localização

- Github::ContributionsScraper
  - Acessa /users/:username/contributions
  - Extrai total de contribuições dos últimos 12 meses

4️⃣ Re-escanear Perfil
  - Disponível via botão na interface
  - Reexecuta o ProfileImporter
  - Atualiza estatísticas sem criar novos registros

5️⃣ Encurtador de URL
- Implementação interna, sem dependência externa:
  - Geração de código aleatório
  - Garantia de unicidade no banco

```bash
URL final:
http://localhost:3000/aZ39Kd
```

## 🎨 Interface (Frontend)
- Bootstrap 5 via CDN
- Navbar, Footer e Layout reutilizáveis
- Modal único para:
  - Cadastro
  - Edição (reutilização do mesmo formulário)

- Tooltips e ícones para melhor UX
- Flash messages globais (success / error)

## 🧪 Testes Automatizados
- Stack de Testes
  - RSpec
  - FactoryBot
  - Shoulda Matchers
- Cobertura
  - Models
  - Services (Scrapers, Importer, Short URL Generator)
  - Validações
  - Regras de negócio

## ▶️ Como Rodar o Projeto Localmente
⚙️ Requisitos

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)

## 🛠️ Setup

1. **Clone o repositório:**

```bash
git clone git@github.com:jorgemtoledo/profile_aggregator.git
cd profile_aggregator
```
2. **Configure o ambiente:**

Crie um arquivo `.env` com base no exemplo:

```bash
cp .env.example .env
```
---

## 🐳 Rodando com Docker

Suba a aplicação com:

```bash
docker compose up --build
```

Acesse em: [http://localhost:3000](http://localhost:3000)

---
## 🔧 Comandos úteis

### Acessar o container Rails:

```bash
docker compose exec web bash
```

### Rodar o console do Rails:

```bash
docker compose exec web bin/rails console
```

## 🧪 Testes

Usando RSpec:

```bash
docker compose exec web bundle exec rspec
```

```bash
docker compose exec web bundle exec rspec spec/services/github/profile_importer_spec.rb
```

---

🛠️ Decisões Técnicas Importantes
  - Web Scraping foi escolhido conforme exigido no desafio
  - Service Objects evitam lógica nos controllers
  - Dados editáveis e dados extraídos foram separados
  - URL Shortener próprio evita dependências externas
  - Docker garante ambiente reprodutível
  - Testes garantem segurança para re-scan e updates

## 🔗 Link do projeto
- Acesse em: [https://profile-aggregator.onrender.com]([https://profile-aggregator.onrender.com)

---

## 📝 Autor
- Autor: Jorge Toledo
- Email: jorge.toledo@gmail.com