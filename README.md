# 📱 Post List Test

Este é um projeto Flutter que implementa uma aplicação de listagem de posts, utilizando **Flutter Bloc**, **Hive** para persistência local e **Dio** para requisições HTTP.

## 🚀 Tecnologias Utilizadas

- **Flutter** 🏗️
- **Dio** 🔥 (para comunicação HTTP)
- **Flutter Bloc** 📦 (para gerenciamento de estado)
- **Hive** 📂 (para armazenamento local)
- **Go Router** 🚀 (para navegação)
- **Get It** 🧩 (para injeção de dependências)
- **Flex Color Scheme** 🎨 (para temas dinâmicos)
- **Equatable** ⚖️ (para comparar objetos facilmente)
- **Dartz** 🎯 (para manipulação de erros com Either)
- **Formz** 📋 (para validação de formulários)

---

## 📦 Configuração do Ambiente

### 1️⃣ **Clone o repositório**

```sh
git clone https://github.com/seu-usuario/post_list_test.git
cd post_list_test
```

### 2️⃣ **Instale as dependências**

```sh
flutter pub get
```

### 3️⃣ **Execute o projeto**

```sh
flutter run
```

---

## ⚙️ Estrutura do Projeto

```
lib/
│── core/                     # Módulos centrais do app
│   ├── di/                   # Injeção de dependências (GetIt)
│   ├── router/               # Configuração das rotas (Go Router)
│   ├── services/             # Serviços globais (Hive, API, etc.)
│
│── features/                 # Módulos do app
│   ├── data/                 # Camada de dados (Modelos, Repositórios, Data Sources)
│   ├── domain/               # Camada de domínio (Entidades, Casos de Uso, Repositórios)
│   ├── presenter/            # Camada de apresentação (Cubits, Páginas, Widgets)
│
│── main.dart                 # Ponto de entrada do app
```

---

## 📌 Dependências Principais

```yaml
dependencies:
  flutter:
    sdk: flutter
  go_router: ^14.8.0
  flutter_bloc: ^9.0.0
  get_it: ^8.0.3
  dio: ^5.8.0+1
  flex_color_scheme: ^8.1.0
  equatable: ^2.0.7
  dartz: ^0.10.1
  formz: ^0.8.0
  hive: ^2.2.3
  hive_flutter: ^1.1.0
```

---

## 🛠️ **Rodando os Testes**

O projeto contém testes unitários utilizando `bloc_test` e `mocktail`. Para rodá-los, utilize:

```sh
flutter test
```

---

## 📜 **Gerando Código com Build Runner**

Algumas classes (como os Adapters do Hive) são geradas automaticamente. Para regenerá-las, utilize:

```sh
flutter pub run build_runner build
```

Caso queira limpar antes de gerar novamente:

```sh
flutter pub run build_runner build --delete-conflicting-outputs
```

---

Desenvolvido com ❤️ por [Johnathan Rocha](https://github.com/John-Rocha)
