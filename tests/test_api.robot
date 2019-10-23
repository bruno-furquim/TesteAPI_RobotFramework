*** Settings ***
Documentation   Documentação da API:    https://fakerestapi.azurewebsites.net/api/Authors
Resource        C:/TesteRobot/TestAPI/resource/resource_api.robot
Suite Setup     Conectar na API

*** Test Case ***
#(GET em todos os livros)
Caso de teste 01: Buscar a listagem de todos os autores
    Requisitar todos os autores
    Conferir o status code      200
    Conferir o reason           OK
    # Conferir se retorna uma lista com "400" autores

Caso de teste 02: Buscar um autor específico
#(GET em um livro específico)
    Requisitar o autor "5"
    Conferir o status code      200
    Conferir o reason           OK
    Conferir se retorna todos os dados corretos do autor "5"

Caso de teste 03: Cadastrar um novo autor (POST)
    Cadastrar um novo autor
    # Conferir se retorna todos os dados cadastrados para o novo autor
# TO-DO: Alterar um livro (PUT)
#   - Conferir se retorna todos os dados do livro 15
# TO-DO: Deletar um livro (DELETE)
#   - Conferir se deleta o livro 200
