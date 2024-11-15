# Bookbook

## Instructions for Running the Project

First, you need to install the required gems by running:
```ruby
bundle install
```
Next, create a ```.env``` file in the project root directory with the following fields:
```ruby
DATABASE=your_db_name
DB_USERNAME=your_db_user
PASSWORD=your_db_password
HOST=your_db_host  # Usually 'localhost' in development
DB_PORT=your_db_port  # PostgreSQL usually runs on port 5432
```
Then, in your terminal, run the following commands to set up the database:
```ruby
rails db:create
rails db:migrate
```
After setting up the database, run the server with:
```ruby
rails server
```

## How to Use the App
You need to create an admin and users. To do this, the app provides the following routes:

* ```/admins/sign_up``` for register an admin
* ```/admins/sign_in``` for loggin with an admin profile

The logout button is located in the bottom-left corner of the page. Once logged in, it changes to show the user's name. You can also find the login button for regular users in the same location.

Once logged in, you can:

* Create posts
* Change post states (only admins can change the state)
* Create comments (only users can comment)

The app interface is intuitive, making these tasks simple to complete.

Enjoy using Bookbook!