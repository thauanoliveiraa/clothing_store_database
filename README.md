# 📊 Sistema Gerenciador Financeiro e Gerenciador de Estoque (SGFGE)

## 🌟 Idealização do Projeto

<strong>🔗<a href="https://docs.google.com/presentation/d/1ImoG3nhUriZNBXfOEuz4uWU0EWqq7jEwBx7tyl8M1eM/edit#slide=id.g2e21abd7fd9_0_23">Acesse aqui a apresentação em slide completa</a></strong>
<br>
<br>
<summary>📌 O que é para ser feito?</summary>
<br>
O objetivo principal é desenvolver um script SQL que realizará algumas atividades específicas. O intuito geral é usar o que foi aprendido em sala, desde o conceito de modelagem à utilização de chaves primárias e estrangeiras, com uma temática determinada. Nós propomos o pré-desenvolvimento de um sistema, utilizando linguagem de programação para realizar requisições no banco de dados.
<br>
<br>
O objetivo é desenvolver um sistema para a **gestão financeira** e a **gerência de estoque** de uma loja de roupas (SGFGE), contendo também um sistema de solicitação de reembolso que armazenará informações sobre os usuários (clientes), suas compras e as solicitações de troca e reembolso.

## 📑 Requisitos Funcionais (RF)

<details>
<summary>💼 Requisitos do Gerenciamento Financeiro</summary>
<br>
<strong>⚙️ RF01:</strong> <p>O sistema deve permitir o cadastro de fornecedores, incluindo informações como: CNPJ, Nome e Descrição.</p>
<br>
<strong>⚙️ RF02:</strong><p>O sistema deve permitir o cadastro de funcionários, incluindo informações como: Nome, Salário e CPF.</p>
<br>
<strong>⚙️ RF03:</strong> <p>O sistema deve permitir a edição e exclusão de fornecedores, permitindo editar apenas as informações como "Nome" e "Descrição" e excluir os fornecedores de forma permanente, incluindo todos os dados.</p>
<br>
<strong>⚙️ RF04:</strong><p>O sistema deve permitir a edição e exclusão de funcionários, permitindo editar apenas informações como "Nome" e "Salário" e excluir os funcionários de forma permanente, incluindo todos os dados.</p>
<br>
<strong>⚙️ RF05:</strong><p>O sistema deve permitir o aceite de solicitações de cancelamento de produtos enviados pelo cliente, realizando o estorno do valor pago pelo cliente e a volta do produto comprado para o estoque.</p>
<br>
<strong>⚙️ RF06:</strong> <p>O sistema deve permitir realizar o pagamento de funcionários e fornecedores (pagamento/compra de produtos) apenas digitando o valor, registrando e diminuindo o saldo geral disponível (atualizando).</p>
<br>
<strong>⚙️ RF07:</strong><p>O sistema deve exibir a visualização do saldo disponível no caixa, realizando atualizações sempre que necessário.</p>
<br>
<strong>⚙️ RF08:</strong><p>O sistema deve exibir a lista de funcionários, fornecedores e solicitações de cancelamento, independentemente de serem na mesma tela ou não.</p>
<br>
</details>

<details>
<summary>🏷️ Requisitos do Gerenciamento de Estoque</summary>
<br>
<strong>⚙️ RF09:</strong><p>O sistema deve permitir o cadastro de produtos, incluindo informações como Nome, Preço de Venda, Tamanho, Cor, Tipo de Produto e Preço de Compra do Fornecedor.</p>
<br>
<strong>⚙️ RF10:</strong><p>O sistema deve permitir a edição e exclusão de produtos, permitindo editar apenas informações como Nome, Preço de Venda, Tamanho, Cor, Tipo de Produto e Preço de Compra do Fornecedor e excluir os produtos de forma permanente, incluindo todos os dados.</p>
<br>
<strong>⚙️ RF11:</strong><p>O sistema deve exibir a lista de produtos disponíveis de forma geral.</p>
<br>
<strong>⚙️ RF12:</strong><p>O sistema deve exibir detalhes de cada produto ao ser clicado, apenas expandindo a visualização das informações.</p>
<br>
</details>
 
## ⚙️ Requisitos Não Funcionais (RNF)

<details>
<summary>Clique para visualizar os Requisitos Não Funcionais (RNF)</summary>
<br>
<strong>🔨 RNF01:</strong> O sistema deve ser desenvolvido utilizando tecnologias como: C#, .NET Core, Razor, Entity Framework, HTML, CSS, JavaScript, SQL Workbench, XAMPP, Bootstrap, Photoshop, Figma, entre outras.
<br>
<br>
<strong>🔨 RNF02:</strong> O sistema deve seguir o padrão e arquitetura de desenvolvimento MVC.
<br>
<br>
<strong>🔨 RNF03:</strong> O sistema deve ser desenvolvido utilizando conceitos de programação orientada a objetos.
<br>
<br>
<strong>🔨 RNF04:</strong> O sistema deve ser armazenado em repositório no GitHub, removendo códigos, trechos de códigos, materiais e outras coisas importantes para o seu funcionamento, a fim de evitar possíveis cópias não autorizadas.
<br>
<br>
<strong>🔨 RNF05:</strong> O sistema deve ser executado localmente.
<br>
<br>
<strong>🔨 RNF06:</strong> O sistema deve ser armazenado localmente.
<br>
<br>
</details>

## 📋 Regras de Negócio (RN)

<details>
<summary>Clique para visualizar as Regras de Negócio (RN)</summary>
<br>
<strong>⚖️ RN01:</strong> O sistema deverá seguir os padrões e termos determinados na LGPD.
</details>

## 💻 Tecnologias a serem Utilizadas

<summary>Clique para visualizar as Tecnologias a serem Utilizadas</summary>
<br>

### 🖥️ Linguagens de Programação
- **C#** (Linguagem utilizada)
  - .NET Core
  - Frameworks: Razor, Entity Framework

### 🌐 Linguagem de Marcação
- HTML

### 🎨 Linguagem de Estilização
- CSS

### 🗃️ Query Language
- SQL (Utilizar a partir do Workbench + XAMPP)

### 🛠️ Outras Tecnologias e Ferramentas
- **Design:** Photoshop, Figma, entre outros.
- **Suporte:** GPT Gemini.
- **Outros:** Bootstrap (quando necessário).


## 🏛️ Padrões e Arquiteturas de Desenvolvimento a serem Utilizadas

<details>
<summary>Clique para visualizar os Padrões e Arquiteturas de Desenvolvimento</summary>
<br>
<strong>Programação Orientada a Objetos</strong>
<br>
<br>
<strong>MVC (Model View Controller)</strong>
<br>
<br>
<strong>Controle de Versão (Git)</strong>
<br>
<br>
</details>

## 🗂️ Modelagem (Diagramas e outras modelagens a serem realizadas)

<details>
<summary>Clique para visualizar os Modelos de Diagramas</summary>
<br>
<strong>Diagrama de Classes:</strong> Representa as classes do sistema, os atributos, métodos e relacionamentos entre elas. É útil para modelar a estrutura e o comportamento das entidades do sistema.
<br>
<br>
<strong>Diagrama de Casos de Uso:</strong> Mostra as interações entre os atores (usuários ou sistemas externos) e as funcionalidades do sistema. Ele ajuda a identificar os requisitos funcionais do sistema e as principais interações entre os usuários e o software.
<br>
<br>
<strong>Diagrama de Atividades:</strong> Descreve o fluxo de atividades ou processos no sistema, mostrando as decisões, bifurcações e paralelismos. É especialmente útil para modelar lógica de negócios e processos.
<br>
<br>
<strong>Diagrama de Cardinalidade:</strong> Descreve o fluxo de atividades de acordo com as relações de classes (1 para 1, 1 para muitos, muitos para muitos, entre outros exemplos).
<br>
<br>
</details>

## 🚀 Etapas de Desenvolvimento


<summary>Clique para visualizar as Etapas de Desenvolvimento</summary>
<br>
1. <strong>Idealização das Classes:</strong> Definir quais serão as classes (entidades) do sistema, desenvolvendo o diagrama de classes UML (trazendo atributos e métodos dessas classes).
<br>
<br>
2. <strong>Relações das Classes:</strong> Definir as relações entre essas classes (entidades) para facilitar a criação do diagrama do banco de dados, incluindo a criação de tabelas, chaves primárias, estrangeiras, entre outros aspectos.
<br>
<br>
3. <strong>Diagrama de Cardinalidade:</strong> Utilizar as relações definidas no segundo passo para criar o diagrama de cardinalidade de classes (entidades).
<br>
<br>
4. <strong>Diagrama de Casos de Uso:</strong> Desenvolver o diagrama de casos de uso.
<br>
<br>
5. <strong>Diagrama de Atividades:</strong> Desenvolver o diagrama de atividades do sistema.
<br>
<br>

