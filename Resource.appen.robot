*** Settings ***
Library				SeleniumLibrary
Library 			String
Library             DateTime
Library             Collections

*** Variables ***
${url1}                 https://srt.facebook.com/login/?email=porntiwa.chokdumrongsook%40fb.appen.com
${url2}                 https://review.intern.facebook.com/intern/review/
${username}             porntiwa.chokdumrongsook@fb.appen.com
${password}             Snitch2963

${login_btn}            button[value='1']
${email}                input[name='email']
${input_password}       input[name='pass']

${body_page}            body.UIInternPage
${just_go_btn}          a[href*='intern/review/queue/endless']

${review_page}          div[data-uibase-classes=':srt:job-container:view']
${submit_btn}           //button[text()='Submit']
${dump_btn}             //div[text()='Dump and Exit']

${text_to_review}       //span[@data-uibase-classes=':xui:text']

${11_pieces}            //div[text()='11 out of']

# Demonization of a Group
${demo_none}            xpath=(//b[text()='None of the above']/../..//div//span)[1]
${demo_text_maybe}      xpath=(//b[text()='Text']/../..//div//span)[2]

# Toxicity
${toxicity_toxic}       //label[text()='Toxic (rude, disrespectful, or unreasonable that is somewhat likely to make you want to avoid this content)']
${toxicity_neither}     //label[text()='Neither']
${toxicity_healthy}     //label[text()='Healthy content (reasonable, civil, or polite content that is somewhat likely to make you want to engage)']

# Where Toxicity
${toxic_locate_none}                    xpath=(//b[text()='None of the above']/../..//div//span)[2]
${toxic_locate_text_yes}                xpath=(//b[text()='Text']/../..//div//span)[3]
${toxic_locate_text_maybe}              xpath=(//b[text()='Text']/../..//div//span)[4]
${toxic_locate_image_video_yes}         xpath=(//b[text()='Image or video']/../..//div//span)[3]
${toxic_locate_image_video_maybe}       xpath=(//b[text()='Image or video']/../..//div//span)[4]
${toxic_locate_link_yes}                xpath=(//b[text()='Link preview']/../..//div//span)[3]
${toxic_locate_link_maybe}              xpath=(//b[text()='Link preview']/../..//div//span)[4]
${toxic_locate_image_text_overlay}      xpath=(//b[text()='How is the Healthy or Toxic content expressed? (Choose all that apply.)']/../..//div//span)[1]
${toxic_locate_image_imagery}           xpath=(//b[text()='How is the Healthy or Toxic content expressed? (Choose all that apply.)']/../..//div//span)[3]
${toxic_locate_image_in_the_image}      xpath=(//b[text()='Where is the Healthy or Toxic located? (Choose all that apply.)']/../..//div//span)[1]
${toxic_locate_image_video_thumbnail}   xpath=(//b[text()='Where is the Healthy or Toxic located? (Choose all that apply.)']/../..//div//span)[2]
${toxic_locate_image_end_video}         xpath=(//b[text()='Where is the Healthy or Toxic located? (Choose all that apply.)']/../..//div//span)[3]
${toxic_locate_image_begin_video}       xpath=(//b[text()='Where is the Healthy or Toxic located? (Choose all that apply.)']/../..//div//span)[4]

*** Keywords ***
Click Submit
    wait until element is enabled       ${submit_btn}       5
    Scroll Height
    sleep   5s
    click element                       ${submit_btn}
    sleep  2s

Select Demonization None
    Scroll Out From Bottom              ${demo_none}
    click element                       ${demo_none}
    capture page screenshot

Select Demonization Text Maybe
    Scroll Out From Bottom              ${demo_text_maybe}
    click element                       ${demo_text_maybe}
    capture page screenshot

Select Toxicity Toxic
    Scroll Out From Bottom              ${toxicity_toxic}
    click element                       ${toxicity_toxic}
    capture page screenshot

Select Toxicity Healthy
    Scroll Out From Bottom              ${toxicity_healthy}
    click element                       ${toxicity_healthy}
    capture page screenshot

Select Toxicity Neither
    Scroll Out From Bottom              ${toxicity_neither}
    click element                       ${toxicity_neither}
    capture page screenshot

Select Toxicity Locate None
    Scroll Height
    click element                       ${toxic_locate_none}
    capture page screenshot

Select Toxicity Locate Text Yes
    Scroll Out From Bottom              ${toxic_locate_text_yes}
    click element                       ${toxic_locate_text_yes}
    capture page screenshot

Select Toxicity Locate Text Maybe
    Scroll Out From Bottom              ${toxic_locate_text_maybe}
    click element                       ${toxic_locate_text_maybe}
    capture page screenshot

Select Toxicity Locate Image Video Yes
    Scroll Out From Bottom              ${toxic_locate_image_video_yes}
    click element                       ${toxic_locate_image_video_yes}
    capture page screenshot

Select Toxicity Locate Image Video Maybe
    Scroll Out From Bottom              ${toxic_locate_image_video_maybe}
    click element                       ${toxic_locate_image_video_maybe}
    capture page screenshot

Select Toxicity Locate Link Preview Yes
    Scroll Out From Bottom              ${toxic_locate_link_yes}
    click element                       ${toxic_locate_link_yes}
    capture page screenshot

Select Toxicity Locate Link Preview Maybe
    Scroll Out From Bottom              ${toxic_locate_link_maybe}
    click element                       ${toxic_locate_link_maybe}
    capture page screenshot

Select Toxicity Expressed Text Overlay
    Scroll Out From Bottom With Number      ${toxic_locate_image_text_overlay}   250
    click element                       ${toxic_locate_image_text_overlay}
    capture page screenshot

Select Toxicity Expressed Using Imagery
    sleep  1s
    Scroll Out From Bottom With Number      ${toxic_locate_image_imagery}     250
    click element                       ${toxic_locate_image_imagery}
    capture page screenshot

Select Toxicity Where Located In The Image
    Scroll Out From Bottom With Number      ${toxic_locate_image_in_the_image}      300
    click element                       ${toxic_locate_image_in_the_image}
    capture page screenshot

Select Toxicity Where Located In The Video Thumbnail
    Scroll Out From Bottom              ${toxic_locate_image_video_thumbnail}
    click element                       ${toxic_locate_image_video_thumbnail}
    capture page screenshot

Select Toxicity Where Located End Of Video
    Scroll Out From Bottom              ${toxic_locate_image_end_video}
    click element                       ${toxic_locate_image_end_video}
    capture page screenshot

Select Toxicity Where Located Begin Of Video
    Scroll Out From Bottom              ${toxic_locate_image_begin_video}
    click element                       ${toxic_locate_image_begin_video}
    capture page screenshot

Select Toxic Neither At None
    Select Toxicity Neither
    random sleep
    Select Toxicity Locate None
    random sleep

Select Toxic In Text Yes
    [Arguments]     ${toxicity}

    run keyword if  '${toxicity}'=='Toxic'      Select Toxicity Toxic
    run keyword if  '${toxicity}'=='Healthy'    Select Toxicity Healthy
    random sleep
    Select Toxicity Locate Text Yes
    random sleep

Select Toxic In Text Maybe
    [Arguments]     ${toxicity}

    run keyword if  '${toxicity}'=='Toxic'      Select Toxicity Toxic
    run keyword if  '${toxicity}'=='Healthy'    Select Toxicity Healthy
    random sleep
    Select Toxicity Locate Text Maybe
    random sleep

Select Toxic In Image Yes Text Overlay In The Image
    [Arguments]     ${toxicity}

    run keyword if  '${toxicity}'=='Toxic'      Select Toxicity Toxic
    run keyword if  '${toxicity}'=='Healthy'    Select Toxicity Healthy
    random sleep
    Select Toxicity Locate Image Video Yes
    Select Toxicity Expressed Text Overlay
    Select Toxicity Where Located In The Image
    random sleep

Select Toxic In Image Maybe Text Overlay In The Image
    [Arguments]     ${toxicity}

    run keyword if  '${toxicity}'=='Toxic'      Select Toxicity Toxic
    run keyword if  '${toxicity}'=='Healthy'    Select Toxicity Healthy
    random sleep
    Select Toxicity Locate Image Video Maybe
    Select Toxicity Expressed Text Overlay
    Select Toxicity Where Located In The Image
    random sleep

Select Toxic In Image Yes Imagery In The Image
    [Arguments]     ${toxicity}

    run keyword if  '${toxicity}'=='Toxic'      Select Toxicity Toxic
    run keyword if  '${toxicity}'=='Healthy'    Select Toxicity Healthy
    random sleep
    Select Toxicity Locate Image Video Yes
    Select Toxicity Expressed Using Imagery
    Select Toxicity Where Located In The Image
    random sleep

Select Toxic In Image Yes Imagery In Video Thumbnail
    [Arguments]     ${toxicity}

    run keyword if  '${toxicity}'=='Toxic'      Select Toxicity Toxic
    run keyword if  '${toxicity}'=='Healthy'    Select Toxicity Healthy
    random sleep
    Select Toxicity Locate Image Video Yes
    Select Toxicity Expressed Using Imagery
    Select Toxicity Where Located In The Video Thumbnail
    random sleep

Select Toxic In Image Yes Imagery In Video
        [Arguments]     ${toxicity}

    run keyword if  '${toxicity}'=='Toxic'      Select Toxicity Toxic
    run keyword if  '${toxicity}'=='Healthy'    Select Toxicity Healthy
    random sleep
    Select Toxicity Locate Image Video Yes
    Select Toxicity Expressed Using Imagery
    Select Toxicity Where Located End Of Video
    Select Toxicity Where Located Begin Of Video
    random sleep

Random Sleep
    ${time}=    Evaluate    random.sample(range(2, 7), 1)    random
    #${time}=    Evaluate    random.sample(range(1, 2), 1)    random
    ${time_to_sleep}=     get from list        ${time}      0
    sleep       ${time_to_sleep}s

Scroll Height
    Execute JavaScript				window.scrollTo(0, document.body.scrollHeight)

Scroll Out From Bottom
    [Arguments]     ${element}

    Assign Id To Element                ${element}        tempID
    Execute Javascript                  document.getElementById('tempID').scrollIntoView()
    ${axis_y}=          Execute Javascript      return window.scrollY
    ${scrollTo}=        Evaluate                ${axis_y}+150
    Execute Javascript                  window.scrollTo(0,${scrollTo})

Scroll Out From Bottom With Number
    [Arguments]     ${element}      ${number}

    Assign Id To Element                ${element}        tempID
    Execute Javascript                  document.getElementById('tempID').scrollIntoView()
    ${axis_y}=          Execute Javascript      return window.scrollY
    ${scrollTo}=        Evaluate                ${axis_y}+${number}
    Execute Javascript                  window.scrollTo(0,${scrollTo})