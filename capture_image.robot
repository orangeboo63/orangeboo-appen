*** Settings ***
Library     SeleniumLibrary
Library     OperatingSystem
Library     capture.Capture
Library     capture.Compare
Library     pytesseract
Resource    Resource.appen.robot

*** Test Cases ***
compare
    ${img1}=    set variable  ${CURDIR}${/}test-content-31-1.png
    ${img2}=    set variable  ${CURDIR}${/}test-content-31-Detail.png

    ${result}=  compare image   ${OUTPUT_DIR}   ${img1}     ${img2}
    log to console      ${result}

capture2
    ${img}=     Set Variable   ${CURDIR}${/}content-23.png
    crop only photo      ${OUTPUT_DIR}   ${img}      20  120      400     500
    ${text}=            image to string         ${img}      lang=tha

test
    ${result}=      Set Variable    0.39
    ${min}=     Set Variable    0.0
    ${max}=     Set Variable    0.4

    #${similar}=     run keyword and return status      should be true   ${min} < ${result} < ${max}
    #log to console      ${similar}

    run keyword if      ${min} <= ${result} <= ${max}     log to console      Pass

test2
    ${file_to_compare}=     set variable        ${CURDIR}${/}test-content-11.png
    Crop Image              ${CURDIR}              ${file_to_compare}

    ${count}=       Count Files In Directory    ${toxic_image_folder}

    :For    ${i}    IN RANGE    1   ${count}+1
    \   ${isImageSimilar}=      Evaluate Image    ${OUTPUT_DIR}   ${file_to_compare}      ${toxic_image_folder}/${i}.png
    #\   exit for loop if        '${isImageSimilar}'=='similar'

    log to console          ${isImageSimilar}