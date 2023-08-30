*** Settings ***
Library     SeleniumLibrary
Library    Collections
Library    String
Library    XML
Library    Screenshot

Test Setup      Open Browser    ${imdbUrl}    Chrome
Test Teardown   Close Browser

*** Variables ***
${imdbUrl}      https://www.imdb.com/
${selectedMovieName}     The Shawshank Redemption
${minDate}      ${2010}
${maxDate}      ${2020}
${expectedNumOfMovies}      ${250}


*** Keywords ***
Sleep3
    Sleep    3

Sleep5
    Sleep    5


*** Test Cases ***

# Verify user can search for a movie on the IMDb homepage
Scenario 1
    Maximize Browser Window
    Input Text    xPath=//input[@id='suggestion-search']    ${selectedMovieName}
    Sleep3
    Take Screenshot     11-GetInput In Search Field
    Click Button    xPath=//*[@id="suggestion-search-button"]
    Wait Until Page Contains Element    xPath=//*[@id="__next"]/main/div[2]/div[3]/section/div/div[1]/section[2]
    Take Screenshot     12-Show Elements After Click Search Button
    Page Should Not Contain    No results found for "${selectedMovieName}"
    Sleep3

    # Check if the first film in results is film entered in search query
    ${firstResult}      Get Text    //*[@id="__next"]/main/div[2]/div[3]/section/div/div[1]/section[2]/div[2]/ul/li[1]/div[2]/div/a
    Should Be Equal   ${firstResult}    ${selectedMovieName}
    Sleep3


    Click Button    xPath=//*[@id="__next"]/main/div[2]/div[3]/section/div/div[1]/section[2]/div[2]/div/span/button
    Sleep5

    # Check if that the display movies related to the search query
    ${elementsNames}=    Get WebElements    class=ipc-metadata-list-summary-item__t
    ${SelectedMovieNameLower}      Convert To Lower Case       ${selectedMovieName}
    FOR    ${element}    IN    @{elementsNames}
        ${elementName}      Get Text    ${element}
        ${elementName}      Convert To Lower Case       ${elementName}
        Should Contain    ${elementName}    ${SelectedMovieNameLower}
    END


# Verify user can access the top-rated movies section
Scenario 2
    Maximize Browser Window
    Click Element    xPath=//*[@id="imdbHeader-navDrawerOpen"]
    Sleep3
    Take Screenshot     21-The List When Click On Menu
    Click Link    xPath=//*[@id="imdbHeader"]/div[2]/aside/div/div[2]/div/div[1]/span/div/div/ul/a[2]
    Wait Until Page Contains Element    xPath=//*[@id="main"]/div/span/div/div/div[3]/div/div/div[1]
    Take Screenshot     22-The Page After Click TOP ${expectedNumOfMovies} Movies

    # Check that Link directed to the Top 250 Movies movies section page
    Location Should Be    ${imdbUrl}chart/top/?ref_=nv_mv_${expectedNumOfMovies}
    Wait Until Page Contains Element    xPath=//*[@id="main"]/div/span/div/div/div[3]/table/tbody/tr[1]/td[5]/div/div

    # Check number of movies that displayed is exactly expected Number Of Movies
    ${allMovies}=    Get WebElements    class=titleColumn
    ${numOfMovies}=     Get Length    ${allMovies}
    ${numOfMovies}=     Convert To Integer    ${numOfMovies}
    Should Be Equal    ${numOfMovies}    ${expectedNumOfMovies}
    Sleep3

    # Check that first movie in the list should be "The Shawshank Redemption"
    ${firstMovie}=      Get WebElement    xPath=//*[@id="main"]/div/span/div/div/div[3]/table/tbody/tr[1]/td[2]/a
    ${firstMovieName}=  Get Text    ${firstMovie}
    Should Be Equal    ${firstMovieName}    The Shawshank Redemption
    Sleep3


# Verify user can search for movies released in a specific year on IMDb
Scenario 3
    Maximize Browser Window
    Click Element    xPath=//*[@id="nav-search-form"]/div[1]
    Sleep3
    Take Screenshot     31-The List When Click On All
    Click Element    xPath=//span[.='Advanced Search']
    Wait Until Page Contains Element    //*[@id="main"]/div[2]/div[1]
    Sleep3
    Take Screenshot     32-The Page After Click Advanced Search
    Click Link    xPath=//*[@id="main"]/div[2]/div[1]/a
    Wait Until Page Contains Element    xPath=//*[@id="main"]
    Sleep3
    Take Screenshot     33-The Page After Click Advanced Title Search
    Click Element    xPath=//*[@id="title_type-1"]
    Click Element    xPath=//*[@id="genres-1"]
    Sleep3
    Input Text    name=release_date-min    ${minDate}
    Input Text    name=release_date-max    ${maxDate}
    Take Screenshot     34-The Data that entered
    Sleep3
    Scroll Element Into View    xPath=//*[@id="rvi-div"]/div
    Sleep3
    Take Screenshot     35-Scroll To Click on the Button
    Click Button    xPath=//*[@id="main"]/p[3]/button
    Sleep5

    Take Screenshot     36-The Page After Click on the Button
    Click Link    xPath=//*[@id="main"]/div/div[2]/a[3]
    Wait Until Page Contains Element    xPath=//*[@id="main"]/div/div[3]/div/div[1]

    Take Screenshot     37-The Page After Click on the sorted by user ratings
    ${allYearsOfItems}     Get WebElements    class=lister-item-year
    ${allRatesOfItems}     Get WebElements    class=ratings-imdb-rating
    ${allgenresOfItems}     Get WebElements    class=genre
    Sleep    3

    # Check that all Elements Between 2010 and 2020
    FOR    ${element}    IN    @{allYearsOfItems}
        ${element}      Get Text     ${element}
        ${element}=    Fetch From Right    ${element}    (          #   Stop When get (
        ${element}=    Remove String    ${element}    )
        ${element}      Convert To Integer    ${element}
        Should Be True    ${element}>=${minDate} and ${element}<=${maxDate}
    END
    
    # Check that all Elements are action genre
        FOR    ${element}    IN    @{allgenresOfItems}
            ${element}      Get Text     ${element}
            @{words} =      Split String    ${element}       ,${SPACE}
            List Should Contain Value    ${words}    Action
        END
    
    Sleep    3

    # Check that all Elements Sorted By Ratings
    ${sortedRatesList}    Create List
    ${sortedRatesOriginalList}    Create List
    FOR    ${element}    IN    @{allRatesOfItems}
        ${element}      Get Text     ${element}
        ${element}      Convert To Number    ${element}
        Append To List    ${sortedRatesList}      ${element}
        Append To List    ${sortedRatesOriginalList}      ${element}
    END
    Sort List    ${sortedRatesList}
    Reverse List    ${sortedRatesList}
    Log    ${sortedRatesList}
    Log    ${allRatesOfItems}
    Lists Should Be Equal    ${sortedRatesList}    ${sortedRatesOriginalList}   Items Not Sorted By Rates
    Sleep    5
