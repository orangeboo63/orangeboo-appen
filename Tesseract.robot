*** Settings ***
Library     pytesseract

*** Test Cases ***
test
    ${img}=     Set Variable   ${CURDIR}${/}Screenshot_20180830-153516.png
    get tesseract version
    ${get_text}=        image to string        ${img}  lang=tha
    log     ${get_text}
    ${result}=    run keyword and return status     should contain      ${get_text}     แลของ

    log to console      ${result}