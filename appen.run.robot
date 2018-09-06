*** Settings ***
Library				SeleniumLibrary
Library 			String
Library             DateTime
Library             OperatingSystem
Library             pytesseract
Resource            Resource.appen.robot

*** Test Cases ***
Run
    ${today_date}=      Get Current Date    result_format=%Y-%m-%dT%H:%M:%SZ
    ${current_time}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    Log                                 ${today_date}

    ${screen_dir}=      set variable    ${CURDIR}${/}data${/}Screen${current_time}
    set screenshot directory            ${screen_dir}

    open browser                        ${url1}     Chrome
    Maximize Browser Window
    wait until element is visible       css=${email}
    wait until element is visible       css=${input_password}
    input text                          css=${email}        ${username}
    input text                          css=${input_password}        ${password}
    click element                       css=${login_btn}
    sleep  2s
    go to                               ${url2}
    wait until element is visible       css=${body_page}
    wait until element is visible       css=${just_go_btn}
    click element                       css=${just_go_btn}

    :For    ${i}    IN RANGE        1   51
    \   log to console                      ${i}
    \   wait until element is visible       css=${review_page}
    \   wait until element is visible       ${submit_btn}
    \   capture page screenshot             filename=content-{index}.png
    \   random sleep
    \   Select Demonization None
    \   random sleep
    \   Verify Content                  ${screen_dir}   ${i}
    \   random sleep
    \   Click Submit
    \   random sleep

    click element                       ${dump_btn}
    wait until element is not visible   ${dump_btn}
    wait until element is visible       css=${body_page}

    [Teardown]      close browser

#TestContain
#    ${current_time}=    Get Current Date    result_format=%Y%m%d_%H%M%S
#    ${screen_dir}=      set variable    ${CURDIR}${/}data${/}Screen${current_time}
#    set screenshot directory            ${screen_dir}
#    open browser                        ${url1}     Chrome
#    Maximize Browser Window
#    wait until element is visible       css=${email}
#    wait until element is visible       css=${input_password}
#    input text                          css=${email}        ${username}
#    input text                          css=${input_password}        ${password}
#    click element                       css=${login_btn}
#    sleep  2s
#    go to                               ${url2}
#    wait until element is visible       css=${body_page}
#    wait until element is visible       css=${just_go_btn}
#    click element                       css=${just_go_btn}
#    capture page screenshot             filename=content-{index}.png
#    random sleep
#    Select Demonization None
#    random sleep
#    Evaluate Text From Image            ${screen_dir}   1
#
#    [Teardown]      close browser

*** Keywords ***
Verify Content
    [Arguments]     ${dir}      ${index}
    ${show_text}=       run keyword and return status    element should be visible      ${text_to_review}
    ${image_file}=      set variable      ${dir}${/}content-${index}.png

    run keyword if      ${show_text}      Evaluate Category From Text
    run keyword unless  ${show_text}      Evaluate Category From Image      ${dir}      ${image_file}

Is Content Toxic
    ${toxic_file}=      get file        ToxicWord.txt
    @{toxic_text}=      split to lines  ${toxic_file}
    ${count}=           get length      ${toxic_text}

    ${status}=          set variable    False
    ${text}=            get text       ${text_to_review}
    Log     ${text}

    :For    ${line}     IN      @{toxic_text}
    \   Log     ${line}
    \   ${status}=     run keyword and return status       should contain      ${text}     ${line}
    \   Exit For Loop If        ${status}

    ${status_toxic}=    set variable if     ${status}     Toxic

    [Return]    ${status_toxic}

Is Content Healthy
    ${healthy_file}=      get file          HealthyWord.txt
    @{healthy_text}=      split to lines    ${healthy_file}
    ${count}=             get length      ${healthy_text}

    ${status}=          set variable    False
    ${text}=            get text       ${text_to_review}
    Log     ${text}

    :For    ${line}     IN      @{healthy_text}
    \   Log     ${line}
    \   ${status}=     run keyword and return status       should contain      ${text}     ${line}
    \   Exit For Loop If        ${status}

    ${status_healthy}=    set variable if     ${status}     Healthy

    [Return]    ${status_healthy}

Is Image Toxic
    ${toxic_file}=      get file        ToxicWord.txt
    @{toxic_text}=      split to lines  ${toxic_file}
    ${count}=           get length      ${toxic_text}

    ${status}=          set variable    False
    ${text}=            get text       ${text_to_review}
    Log     ${text}

    :For    ${line}     IN      @{toxic_text}
    \   Log     ${line}
    \   ${status}=     run keyword and return status       should contain      ${text}     ${line}
    \   Exit For Loop If        ${status}

    ${status_toxic}=    set variable if     ${status}     Toxic

    [Return]    ${status_toxic}

Evaluate Category From Text
    ${content_toxic}=       Is Content Toxic
    ${content_healthy}=     Is Content Healthy

    run keyword if      '${content_toxic}'=='Toxic'       Select Toxic In Text Yes    Toxic
    ...     ELSE IF     '${content_healthy}'=='Healthy'     Select Toxic In Text Yes    Healthy
    ...     ELSE        Select Toxic Neither At None

Evaluate Text From Image
    [Arguments]     ${dir}      ${file_to_read}

    Crop Image          ${dir}       ${file_to_read}
    ${text}=            image to string         ${file_to_read}      lang=tha

    ${toxic_file}=      get file        ToxicWord.txt
    @{toxic_text}=      split to lines  ${toxic_file}
    ${count}=           get length      ${toxic_text}

    ${status}=          set variable    False
    Log     ${text}

    :For    ${line}     IN      @{toxic_text}
    \   Log     ${line}
    \   ${status}=     run keyword and return status       should contain      ${text}     ${line}
    \   Exit For Loop If        ${status}

    ${content_toxic_text}=  set variable if     ${status}   Toxic

Evaluate By Compare Image
    [Arguments]     ${dir}      ${file_to_compare}

    Crop Image      ${dir}     ${file_to_compare}

    ${count}=       Count Files In Directory    ${toxic_image_folder}

    :For    ${i}    IN RANGE    1   ${count}+1
    \   ${isImageSimilar}=      Evaluate Image       ${file_to_compare}      ${toxic_image_folder}/${i}.png
    \   exit for loop if        '${isImageSimilar}'=='similar'

    ${content_toxic_image}=  set variable if     '${isImageSimilar}'=='similar'   Toxic

Evaluate Category From Image
    [Arguments]     ${dir}      ${image_file}

    ${content_toxic_text}=      Evaluate Text From Image        ${dir}      ${image_file}
    ${content_toxic_image}=     Evaluate By Compare Image       ${dir}      ${image_file}

    run keyword if      '${content_toxic_text}'=='Toxic'     Select Toxic In Image Maybe Text Overlay In The Image    Toxic
    ...     ELSE IF     '${content_toxic_image}'=='Toxic'    Select Toxic In Image Maybe Text Overlay In The Image    Toxic
    ...     ELSE        Select Toxic Neither At None
