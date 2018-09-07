*** Settings ***
Library     pytesseract
Library     google_vision.ocr_google

*** Test Cases ***
test
    ${img}=     Set Variable   ${CURDIR}${/}Screenshot_20180830-153516.png
    get tesseract version
    ${get_text}=        image to string        ${img}  lang=tha
    log     ${get_text}
    ${result}=    run keyword and return status     should contain      ${get_text}     แลของ

    log to console      ${result}

test_google
    ${img}=     Set Variable   ${CURDIR}${/}content-43.png
    ${get_text}=    text_from_image     ${img}

