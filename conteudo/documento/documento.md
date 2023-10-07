# Guia de sintaxe de Markdown

Markdown é uma linguagem de marcação leve que é usada para criar documentos formatados usando um texto simples. Aqui está um guia completo da sintaxe de Markdown suportada:


## Parágrafos

Para criar um parágrafo de texto basta dar dois enters.

Este já é outro parágrafo de texto.



## Cabeçalhos

Pode criar cabeçalhos usando o símbolo `#`. O número de `#` determina o nível do cabeçalho.

```
# Cabeçalho 1

## Cabeçalho 2

### Cabeçalho 3

#### Cabeçalho 4

##### Cabeçalho 5

###### Cabeçalho 6
```

## Ênfase


*texto em itálico* ou _texto em itálico_

**texto em negrito** ou __texto em negrito__

**_texto em negrito e itálico_** ou *__texto em negrito e itálico__*

~~texto riscado~~



## Listas

### Listas ordenadas


1. Primeiro item
2. Segundo item
3. Terceiro item


### Listas não ordenadas


- Item
* Item
+ Item


### Sublistas

É também possível criar sublistas (ordenadas ou não ordeandas ou mistas).
Para isso basta dar 4 espaços (ou um TAB) desde o início da linha 


1. era uma vez
    - um gato
    - um cão
    - piriquito
2. maltes
3. que tocava piano e
    1. falava francês
    2. falava chinês
        1. Mandarim
        2. Cantonês
    3. falava japonês
4. fim



## Links


[Isto é um link](https://www.google.com)


## Imagens


![texto alt pode ser ignorado](conteudo/documento/gato.png "legenda da figura")




## Códigos

### Código em linha

Use acentos para trás, chamados crases, (`) para formatar o texto como código.

Aqui está `um exemplo` de código em linha.


### Blocos de código

Use três crases (```) para criar um bloco de código:

```
Exemplo de bloco de código
```

Você pode também especificar a linguagem para um destaque de sintaxe apropriado:

```python
def hello_world():
    print("Olá, mundo!")
```

## Citações

Use `>` para criar citações:


> Isto é uma citação.


## Linhas horizontais

Pode usar três ou mais hífens, asteriscos ou sublinhados:



---


***

___


## Tabelas


| Cabeçalho 1 | Cabeçalho 2 |
|-------------|-------------|
| linha 1, col 1 | linha 1, col 2 |
| linha 2, col 1 | linha 2, col 2 |


## Ignorando a formatação Markdown

Se você quer mostrar um caracter especial de Markdown, você pode usar o `\` antes:


\* isto não será formatado como itálico \*
