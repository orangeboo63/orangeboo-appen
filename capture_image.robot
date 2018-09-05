*** Settings ***
Library     SeleniumLibrary
Library     capture.Capture
Resource     Selenium2Screenshots/keywords.robot
Resource    Resource.appen.robot

*** Test Cases ***
capture
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
    wait until element is visible       css=${review_page}
    wait until element is visible       ${submit_btn}

    #open browser                        https://ampos1-qa.ampostech.com     chrome
    #capture page screenshot
    Bootstrap jQuery
    JQuery Should Be Loaded
    #Capture and crop page screenshot    test82.png       ${image_to_review}
    Capture and crop page screenshot    test83.png       css=div.logo

    [Teardown]  close browser

capture2
    ${img}=     Set Variable   ${CURDIR}${/}test-content-31.png
    crop only photo      ${OUTPUT_DIR}   ${img}      20  120      400     500