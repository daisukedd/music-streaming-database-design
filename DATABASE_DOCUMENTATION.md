# **Projeto de Banco de Dados – Sistema de Streaming Musical (Modelo Estilo Spotify)**

**Disciplina:** Banco de Dados – MySQL Workbench

**Equipe:** 
                                                        
                                                  Arthur Felipe de Carvalho de Brito;
                                                    Glaucia Maria Brito de Oliveira;
                                                      Kevin Wallen Santos Pinheiro;
                                                        Mirella Lima da Cruz.

---

# 1. Introdução

O projeto consiste no desenvolvimento de um sistema de gerenciamento para um serviço fictício de streaming musical, inspirado em plataformas como o Spotify.
O objetivo é projetar, modelar e implementar um banco de dados relacional utilizando MySQL Workbench, abordando modelo conceitual, lógico e físico.

O documento descreve:

- O escopo do sistema
- Entidades e regras de negócio
- Diagrama conceitual (ER)
- Modelo lógico
- Modelo físico (SQL)
- Inserts e consultas
- Convenções e referências

---

# 2. Escopo do Sistema

O sistema armazenará:

- Artistas
- Álbuns
- Músicas
- Gêneros musicais
- Usuários
- Playlists
- Músicas dentro das playlists
- Histórico de reproduções

### ❌ Fora do escopo:

- Sistema de pagamento
- Regras de recomendação
- Download offline
- Múltiplos planos de assinatura

---

# 3. Regras de Negócio

- Um artista pode lançar vários álbuns.
- Um álbum possui várias músicas.
- Uma música pertence a um único gênero musical.
- Um usuário pode criar várias playlists.
- Uma playlist contém muitas músicas.
- Uma música pode estar em várias playlists.
- O sistema registra cada música reproduzida pelo usuário.
- Cada reprodução mantém data/hora e dispositivo.

---

# 4. Dicionário de Dados

## 4.1 – Artist

**Descrição:** Armazena informações dos artistas presentes no catálogo.
**Atributos:**

- `artist_id` – identificador único
- `name` – nome do artista
- `country` – país de origem
- `debut_year` – ano de estreia
- `bio` – biografia curta (opcional)

**PK:** `artist_id`

---

## 4.2 - Gênero
**Descrição:** Armazena informações dos gêneros musicais.
**Atributos:**

- `genre_id` – identificador único do gênero
- `name` – nome do gênero
- `description` – descrição do gênero

**PK:** `genre_id`

---
## 4.3 - User
**Descrição:** Armazena informações dos usuários cadastrados na plataforma.
**Atributos:**

- `user_id` – identificador único do usuário
- `name` – nome do usuário
- `email` – email do usuário, utilizado principalmente no login
- `password_hash` – senha do usuário, utilizada principalmente no login
- `created_at` – momento da criação da conta (data e o horário)

**PK:** `user_id`

---
## 4.4 - Álbum
**Descrição:** Armazena informações dos álbuns presentes no catálogo.
**Atributos:**

- `album_id` – identificador único do álbum
- `artist_id` – chave estrangeira na tabela artista
- `title` – título do álbum
- `release_year` – ano de estreia
- `label` – descrição curta (opcional)

**PK:** `album_id`
**FK:** `artist_id`

---
## 4.5 - Track
**Descrição:** Armazena informações das faixas individuais presentes no catálogo.
**Atributos:**

- `track_id` – identificador único da faixa
- `album_id` – chave estrangeira na tabela álbum
- `artist_id` – chave estrangeira na tabela artista
- `genre_id` – chave estrangeira na tabela gênero
- `title` – título da faixa
- `duration_seconds` – duração da faixa (em segundos)
- `release_date` – ano de lançamento

**PK:** `track_id`
**FK:** `artist_id`, `album_id`, `genre_id`

---
## 4.6 - Playlist
**Descrição:** Armazena informações das playlists da plataforma.
**Atributos:**

- `playlist_id` – identificador único da playlist
- `user_id` – chave estrangeira na tabela user
- `name` – título da playlist
- `description` – descrição da playlist
- `created_at` – momento de criação da playlist

**PK:** `track_id`
**FK:** `user_id`

---

## 4.7 - PlaylistTrack
**Descrição:** Tabela intermediária entre as tabelas playlist e track.
**Atributos:**

- `playlist_id` – identificador da playlist
- `track_id` – identificador da faixa
- `position` – posição da faixa na playlist
- `added_at` – quando a faixa foi adicionada na playlist

**PK composta:** `track_id`, `playlist_id`

---
## 4.8 - History
**Descrição:** Tabela que armazena toda vez que um usuário toca uma música.
**Atributos:**

- `history_id` – identificador do histórico
- `user_id` – chave estrangeira na tabela user
- `track_id` – chave estrangeira na tabela track
- `listened_at` – momento em que a faixa foi reproduzida
- `device` - aparelho usado pelo usuário para ouvir a música
- `duration_listened_seconds` - duração de reprodução em segundos

**PK composta:** `history_id`,
**FK:** `user_id`, `track_id`


---

# 5. Modelo Conceitual (Diagrama ER)

---

## 5.1 Diagrama Entidade-Relacionamento

> IMG exportada do MySQL Workbench, LucidChart ou Draw.io!

---

## 5.2 Explicação Resumida da Estrutura

O modelo conceitual representa um sistema para streaming musical contendo entidades essenciais: artistas, álbuns, músicas, gêneros musicais, usuários, playlists e histórico de reproduções.
O objetivo é apresentar **entidades, atributos e relacionamentos**, sem se preocupar com tipos de dados específicos.

---

## 5.3 Checklist Conceitual das Entidades

_(nomes em inglês + snake_case no banco + camelCase no código)_

---

### **Artist**

- **Entidade:** Artist
- **PK:** `artist_id`
- **Atributos:**

  - `artist_id`
  - `name`
  - `country`
  - `debut_year`
  - `bio` (opcional)

- **Relacionamentos:**

  - 1 Artist → N Albums

---

### **Album**

- **Entidade:** Album
- **PK:** `album_id`
- **Atributos:**

  - `album_id`
  - `artist_id` (FK)
  - `title`
  - `release_year`
  - `label`

- **Relacionamentos:**

  - 1 Artist → N Albums
  - 1 Album → N Tracks

---

### **Track**

- **Entidade:** Track
- **PK:** `track_id`
- **Atributos:**

  - `track_id`
  - `album_id` (FK, nullable para singles)
  - `artist_id` (FK opcional)
  - `genre_id` (FK)
  - `title`
  - `duration_seconds`
  - `release_date`

- **Relacionamentos:**

  - N Tracks → 1 Genre
  - N Tracks → 1 Album
  - N Tracks ↔ N Playlists (via PlaylistTrack)
  - N Tracks → N History entries

---

### **Genre**

- **Entidade:** Genre
- **PK:** `genre_id`
- **Atributos:**

  - `genre_id`
  - `name`
  - `description`

- **Relacionamentos:**

  - 1 Genre → N Tracks

---

### **User**

- **Entidade:** User
- **PK:** `user_id`
- **Atributos:**

  - `user_id`
  - `name`
  - `email` (unique)
  - `password_hash`
  - `created_at`

- **Relacionamentos:**

  - 1 User → N Playlists
  - 1 User → N History records

---

### **Playlist**

- **Entidade:** Playlist
- **PK:** `playlist_id`
- **Atributos:**

  - `playlist_id`
  - `user_id` (FK)
  - `name`
  - `description`
  - `created_at`

- **Relacionamentos:**

  - 1 Playlist ↔ N Tracks (tabela de ligação)

---

### **PlaylistTrack**

- **Tabela de Ligação:** `playlist_track`
- **PK composta:** (`playlist_id`, `track_id`)
- **Atributos:**

  - `playlist_id` (FK)
  - `track_id` (FK)
  - `position`
  - `added_at`

- **Função:**

  - Determina a ordem das músicas na playlist

---

### **History**

- **Entidade:** History
- **PK:** `history_id`
- **Atributos:**

  - `history_id`
  - `user_id` (FK)
  - `track_id` (FK)
  - `listened_at`
  - `device`
  - `duration_listened_seconds`

- **Relacionamentos:**

  - N History → 1 User
  - N History → 1 Track

---

## 5.4 Lista de Relacionamentos e Cardinalidades

| Relacionamento   | Cardinalidade |
| ---------------- | ------------- |
| Artist → Album   | 1:N           |
| Album → Track    | 1:N           |
| Genre → Track    | 1:N           |
| User → Playlist  | 1:N           |
| Playlist ↔ Track | N:N           |
| User → History   | 1:N           |
| Track → History  | 1:N           |

---

# 6. Modelo Lógico

Para cada tabela incluir:

- Nome da tabela
- Colunas com tipos de dados (PK e FKs)
- Cardinalidade
- Observações técnicas
- Regras de validação

_(Conteúdo será preenchido após a criação no Workbench.)_

---

# 7. Modelo Físico (Script SQL)

Incluir:

- CREATE DATABASE
- CREATE TABLE
- PKs e FKs
- UNIQUE
- NOT NULL
- DEFAULT
- AUTO_INCREMENT
- Índices opcionais

---

# 8. Inserção de Dados (Exemplos)

Inclua scripts INSERT para:

- Artists
- Genres
- Albums
- Tracks
- Users
- Playlists
- PlaylistTrack
- History

_(Rodável de uma vez.)_

---

# 9. Consultas SQL (Regras de Negócio)

Exemplos:

- Listar músicas por artista
- Pegar o ranking das músicas mais ouvidas
- Mostrar todas as músicas de uma playlist
- Exibir gênero mais ouvido
- Buscar músicas por termo
- Top artistas por streams

---

# 10. Considerações Finais

- O que foi aprendido
- Dificuldades enfrentadas
- Melhorias futuras
- Possíveis expansões

---

# 11. Referências

- Aulas
- Documentação SQL
- Artigos e vídeos usados

---

# Apêndice A — Convenção de Nomes

- **snake_case** → Banco de dados
- **camelCase** → Código
- PKs seguem padrão: `tableName_id`
- Tabelas N:N seguem padrão: `tabela1_tabela2`

---

# Apêndice B — Mapa dos Relacionamentos

| Tabela        | PK                     | FK                 |
| ------------- | ---------------------- | ------------------ |
| Artist        | artist_id              | –                  |
| Album         | album_id               | artist_id          |
| Track         | track_id               | album_id, genre_id |
| Playlist      | playlist_id            | user_id            |
| PlaylistTrack | playlist_id + track_id | ambos              |
| History       | history_id             | user_id, track_id  |

---
