- Website
  - View all questions - for starting package
  - Add question
  - View answers for each question
  - Registering under company
  - View all individual's answers or answers for question
  - Schedule ask for question frequency
  - Schedule fact emails
  - API to get question answers, answers for user


Flat design

- handlebars float to percentage
- handlebars do no escape html
- nuffly on dependent confirm (in user)

## Loading data from csv
```
require "#{Rails.root}/lib/parsers/old_google_form"
path_to_csv = "#{Rails.root}/olddata.csv"
Parsers::OldGoogleForm.parse_data(path_to_csv, company)
```
