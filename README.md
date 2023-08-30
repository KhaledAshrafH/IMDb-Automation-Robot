# IMDb-Automation-Robot

This repository contains test scripts written in Robot Framework with Selenium Library for testing scenarios on the IMDb website.

## Description

The goal of this project is to create a test suite that verifies the success of three scenarios on the IMDb website using Robot Framework. Each scenario is implemented as a separate test case, and the test suite contains a total of three test cases. The scenarios to be tested are as follows:

### Scenario 1: Verify user can search for a movie on the IMDb homepage

- **Given** that the user is on the IMDb homepage "https://www.imdb.com/"
- **When** the user enters a search query "The Shawshank Redemption" (or any other movie name) in the search bar.
- **And** clicks the search button
- **Then** the search results page should display movies related to the search query.
- **And** the first search result should be "The Shawshank Redemption" movie, i.e., the name written in the search query.

### Scenario 2: Verify user can access the top-rated movies section

- **Given** that the user is on the IMDb homepage "https://www.imdb.com/".
- **When** the user clicks on the "Top 250 Movies" link in the header.
- **Then** the user should be directed to the Top 250 Movies section page.
- **And** the page should display a list of the Top 250 Movies.
- **And** the first movie in the list should be "The Shawshank Redemption".

### Scenario 3: Verify user can search for movies released in a specific year on IMDb

- **Given** that the user is on the IMDb homepage "https://www.imdb.com/"
- **When** the user clicks on the "Advanced Search" link in the search bar filter.
- **Then** the user would be redirected to a page containing the "Advanced Title Search" link, which they should click.
- **And** selects "Feature Film" as the title type.
- **And** selects the "Action" genre from Genres.
- **And** enters a start year and end year in the "Release Date" fields (2010 - 2020).
- **And** clicks the "Search" button.
- **Then** the search results page should display a list of Action movies released between 2010 and 2020, sorted by User Rating (Higher ratings appear first, i.e., descendingly).

## Installation and Setup

To run the tests in this repository, follow the steps below:

1. Clone the repository to your local machine:

```
git clone https://github.com/KhaledAshrafH/IMDb-Automation-Robot.git
```

2. Ensure you have Python installed. The tests were developed using Python 3.7.

3. Install the required dependencies such as: Robot Framework and Selenium Library.

4. Download the appropriate web driver for your browser (Chrome, Firefox, etc.) and add it to your system's PATH.

5. Update the test variables in the `TestSuite.robot` file (if necessary) to match your test environment. The variables include:

- `${imdbUrl}`: The URL of the IMDb homepage.
- `${selectedMovieName}`: The movie name to be used in Scenario 1.
- `${minDate}`: The start year for the search in Scenario 3.
- `${maxDate}`: The end year for the search in Scenario 3.
- `${expectedNumOfMovies}`: The expected number of movies in the top-rated movies section in Scenario 2.

## Running the Tests

To run the test suite, execute the following command:

```
robot imdb.robot
```

This command will execute all the test cases in the `imdb.robot` file.

After the tests complete execution, a log file and an HTML report will be generated in the `log` folder.

## Test Suite Structure

The `imdb.robot` file contains the test suite structure and the test cases for the three scenarios. Each scenario is implemented as a separate test case within the test suite.

The test suite structure includes:

- **Settings**: Libraries and configurations required for the test suite.
- **Variables**: Test variables used in the test cases.
- **Keywords**: Reusable keywords used in the test cases.
- **Test Cases**: Implementation of the test cases for each scenario.

## Test Reports

After running the tests, the log and HTML report files will be generated in the `log` folder. The HTML report provides a detailed overview of the test execution, including the test case status, logs, and screenshots.

## Contributing

Contributions to this repository are welcome. If you find any issues or would like to add new features or scenarios, please open an issue or submit a pull request.

## Acknowledgements

This project was developed using the Robot Framework and Selenium Library, which are open-source technologies. Special thanks to the Robot Framework and Selenium communities for their contributions and support.

## Team

- [Khaled Ashraf Hanafy Mahmoud - 20190186](https://github.com/KhaledAshrafH).
- [Samah Moustafa Hussien Mahmoud - 20190248](https://github.com/Samah-20190248).

## License

This repository is licensed under the [MIT License](LICENSE.md).


