*** Settings ***
Documentation   Documentação da API:    https://fakerestapi.azurewebsites.net/api/Authors
Library         RequestsLibrary
Library         Collections
Library         JSONLibrary

*** Variable ***
${URL_API}        https://fakerestapi.azurewebsites.net/api/
&{AUTHORS_5}      ID=5
...               IDBook=2
...               FirstName=First Name 5
...               LastName=Last Name 5

*** Keywords ***
#Passa os parâmetros necessários para acessar a API
Conectar na API
    Create Session      fakeAPI     ${URL_API}

Requisitar todos os autores
    ${RESPOSTA}     Get Request     fakeAPI     Authors
    Log             ${RESPOSTA.text}
    Set Test Variable   ${RESPOSTA}

Requisitar o autor "${ID_AUTHORS}"
    ${RESPOSTA}         Get Request         fakeAPI     Authors/${ID_AUTHORS}
    Log                 ${RESPOSTA.text}
    Set Test Variable   ${RESPOSTA}

Conferir o status code
    [Arguments]                     ${STATUSCODE_DESEJADO}
    Should Be Equal As Strings      ${RESPOSTA.status_code}      ${STATUSCODE_DESEJADO}
    Log                             Status Code Retornado: ${RESPOSTA.status_code} -- Status Code Esperado: ${STATUSCODE_DESEJADO}

Conferir o reason
    [Arguments]                     ${REASON_DESEJADO}
    Should Be Equal As Strings      ${RESPOSTA.reason}      ${REASON_DESEJADO}
    Log                             Reason Retornado: ${RESPOSTA.reason} -- Reason Desejado: ${REASON_DESEJADO}

# Conferir se retorna uma lista com "${QTDE_AUTHORS}" autores
#     Length Should Be    ${RESPOSTA.json()}    ${QTDE_AUTHORS}

Conferir se retorna todos os dados corretos do autor "${ID_AUTHORS}"
    Dictionary Should Contain Item      ${RESPOSTA.json()}      ID              ${AUTHORS_5.ID}
    Dictionary Should Contain Item      ${RESPOSTA.json()}      IDBook          ${AUTHORS_5.IDBook}
    Dictionary Should Contain Item      ${RESPOSTA.json()}      FirstName       ${AUTHORS_5.FirstName}
    Dictionary Should Contain Item      ${RESPOSTA.json()}      LastName        ${AUTHORS_5.LastName}

Cadastrar um novo autor
    Create Session    fakeAPI    ${URL_API}
    #&{BODY}       Create Dictionary    {"ID":19875,"IDBook":125477,"FirstName":"Sarah J.","LastName":"Maas"}
    &{HEADERS}    Create Dictionary    content-type=application/json  Accept=application/json

    ${RESPOSTA}   Post Request    fakeAPI    Authors
    ...           data={"ID":19875,"IDBook":125477,"FirstName":"Sarah J.","LastName":"Maas"}
    ...           headers=${HEADERS}
    Log To Console    ${RESPOSTA.status_code}
    Log To Console    ${RESPOSTA.content}
    Log To Console    ${RESPOSTA.reason}

    # Dictionary Should Contain Item      ${RESPOSTA.json()}      ID              ${RESPOSTA.ID}
    # Dictionary Should Contain Item      ${RESPOSTA.json()}      IDBook          ${RESPOSTA.IDBook}
    # Dictionary Should Contain Item      ${RESPOSTA.json()}      FirstName       ${RESPOSTA.FirstName}
    # Dictionary Should Contain Item      ${RESPOSTA.json()}      LastName        ${RESPOSTA.LastName}
