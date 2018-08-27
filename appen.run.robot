*** Settings ***
Library				SeleniumLibrary
Library 			String
Library             DateTime
Library             OperatingSystem
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
    \   wait until element is visible       css=${review_page}
    \   wait until element is visible       ${submit_btn}
    \   capture page screenshot             filename=content-{index}.png
    \   random sleep
    \   Select Demonization None
    \   random sleep
    \   Verify Content
    \   random sleep
    \   Click Submit
    \   random sleep

    click element                       ${dump_btn}
    wait until element is not visible   ${dump_btn}
    wait until element is visible       css=${body_page}

    [Teardown]      close browser

#Test Contain
#    ${text}=        Set variable    ลองเล่นออนไลน์กัน
#    ${line}=        Set variable    บอลออนไลน์
#    ${status}=     run keyword and return status       should contain      ${text}     ${line}
#    log         ${status}

*** Keywords ***
Verify Content
    ${show_text}=    run keyword and return status    element should be visible      ${text_to_review}

    run keyword if      ${show_text}      Evaluate Category
    run keyword unless  ${show_text}      Select Toxic Neither At None

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

Evaluate Category
    ${content_toxic}=       Is Content Toxic
    ${content_healthy}=     Is Content Healthy

    run keyword if      '${content_toxic}'=='Toxic'       Select Toxic In Text Yes    Toxic
    ...     ELSE IF     '${content_healthy}'=='Healthy'     Select Toxic In Text Yes    Healthy
    ...     ELSE        Select Toxic Neither At None


