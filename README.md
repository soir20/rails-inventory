# Test the App
The application is already running on [Heroku](https://intense-mesa-60485.herokuapp.com/). If the app has not been used for a while, it may take a few moments to start.

You can:
* create, read, update, and delete inventory items
* create, read, update, and delete named collections of items
* add an item to one collection, change what collection the item is in, or remove it from all collections
    * (A many-to-many relationship between collections and items could later be implemented with a bridge table, but currently, it is kept simpler.)

Beware that deleting a collection will delete all of its items.

# Routes
Please see the [Collection](app/models/collection.rb) and [InventoryItem](app/models/inventory_item.rb) models' documentation for detailed descriptions of acceptable parameters.

| Model         | Path                       | Method    | Description                                |
|---------------|----------------------------|-----------|--------------------------------------------|
| Collection    | /collections/              | GET       | List all collections.                      |
| Collection    | /collections/[id]          | GET       | Show individual collection.                |
| Collection    | /collections/new           | GET       | Interactive form to make a new collection. |
| Collection    | /collections/[id]/edit     | GET       | Interactive form to edit a collection.     |
| Collection    | /collections/              | POST      | Create a collection.                       |
| Collection    | /collections/[id]          | PATCH/PUT | Update a collection.                       |
| Collection    | /collections/[id]          | DELETE    | Destroy a collection.                      |
| InventoryItem | /inventory_items/          | GET       | List all items.                            |
| InventoryItem | /inventory_items/[id]      | GET       | Show individual item.                      |
| InventoryItem | /inventory_items/new       | GET       | Interactive form to make a new item.       |
| InventoryItem | /inventory_items/[id]/edit | GET       | Interactive form to edit an item.          |
| InventoryItem | /inventory_items/          | POST      | Create an item.                            |
| InventoryItem | /inventory_items/[id]      | PATCH/PUT | Update an item.                            |
| InventoryItem | /inventory_items/[id]      | DELETE    | Destroy an item.                           |

The interactive collections index page lists all the items in each collection. The JSON endpoints do not list items within each collection, and there is not an endpoint or parameter to filter them. Currently, you'd need to request all items to find all items in a certain collection through the JSON API.

# Installation Prerequisites
This is a Ruby on Rails application created with:
* Ruby 3.1.0
* Rails 7.0.1
* Bundler 2.3.3

See the [official Rails installation guide](https://guides.rubyonrails.org/getting_started.html#creating-a-new-rails-project-installing-rails) for information about what is needed to install Rails.

You also need to have SQLite3 and PostgreSQL installed. Prisma has detailed instructions about how to install [SQLite](https://www.prisma.io/dataguide/sqlite/setting-up-a-local-sqlite-database) and [Postgres](https://www.prisma.io/dataguide/postgresql/setting-up-a-local-postgresql-database) on Windows, Mac, and Linux.

Clone this repository (see GitHub's green "Code" menu at the upper right).

# Launch a Local Development Server
Within the project directory, install bundle dependencies:
```
$ bundle install
```
If you receive a Bundler exception about a missing Postgres header file, you might need to install `postgresql-contrib` and `libpq-dev` ([StackOverflow](https://stackoverflow.com/questions/52339221/rails-gem-error-while-installing-pg-1-1-3-and-bundler-cannot-continue)).

Set up the database:
```
$ bin/rake db:prepare
$ bin/rake db:migrate
```

There's also a Rails-generated script to run the setup automatically: [bin/setup](bin/setup). You may still need to migrate the database after running the script.

To run the local server:
```
$ bin/rails s
```

# Run Tests

## Regular Tests (Models and Controllers)
```
bin/rake test
```

## System Tests
These tests will open a browser window controlled by the test suite:
```
bin/rake test:system
```

# Set Up a Postgres Production Database
This section explains how to setup the Postgres production database.

The development environment uses a simple SQLite database. If you want to skip this setup, run the app in development mode.

## Install Postgres
See the [installation prerequisites](#installation-prerequisites) for how to install Postgres.

## Create the Database
You can skip this section if deploying to Heroku.

Log in to Postgres:
```
$ sudo -u postgres psql
```

Create the database through the `psql` terminal:
```
CREATE DATABASE database_name;
```

Then connect to the database:
```
\c database_name
```

## Create the User and Grant Permissions
You can skip this section if deploying to Heroku.


Create a new user through the `psql` terminal:
```
CREATE ROLE user_name PASSWORD 'password';
```

See more user/role creation options at the [Postgres documentation](https://www.postgresql.org/docs/current/sql-createrole.html).

You'll also need to grant the new user permissions to connect to and modify the database:
```
GRANT CONNECT ON DATABASE database_name TO user_name;
GRANT CREATE, USAGE ON SCHEMA public TO user_name;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public;
```

## Update `pg_hba.conf`
You can skip this section if deploying to Heroku.

You also need to add a line to the `pg_hba.conf` file in your Postgres installation to allow the new user to connect to the database.
```
local   database_name   user_name   peer
```

Edit this line as necessary according to the [Postgres documentation](https://www.postgresql.org/docs/14/auth-pg-hba-conf.html) based on how you want to connect to the database.

## Environment Variables
If you are not running the app in production on Heroku, you need to uncomment three lines in the `config/database.yml` file. You also need to define the associated environment variables:

| Variable Name | Description                                                                  |
|---------------|------------------------------------------------------------------------------|
| PROD_DB_NAME  | Name of Postgres database you created                                        |
| PROD_DB_USER  | Name of database user with permissions to connect to and modify the database |
| PROD_DB_PASS  | Password of the above user                                                   |

If you deploy to Heroku, you only need to define `PROD_DB_NAME`.

## Migrate
You've already created the database, so you only need to run the database migration task in production:
```
$ RAILS_ENV=production rake db:migrate
```
If your version of the app fails because of missing relations, you probably forgot this step.