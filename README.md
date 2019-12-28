# bjjtechniques

A Brazilian Jiu-Jitsu technique catalog, written in Node.js, EJS, and Javascript.

## 1. Get the code local
```
mkdir bjjtech
cd bjjtech
git init .
git remote add github git@github.com:davecthomas/bjjtech.git
git pull github master
```

## Option A: Local Installation

1. Download and install Node.js and npm: https://www.npmjs.com/get-npm. Tested with Node v13.5.0 and npm v6.13.4.
```
npm install
```
3. If you get a build failure, you may need to install the C runtime libraries: xcode-select --install
4. Install Homebrew: /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
5. Install PostgreSQL: brew install postgresql
6. Start PostgreSQL, set up a user, password, and import sql
```
pg_ctl -D /usr/local/var/postgres start
psql -d bjjtech -U <you>
ALTER USER <you> PASSWORD 'password'
\quit
```
7. Import SQL into the DB
```
psql bjjtech < bjjt_schema_data.sql
```
8. Create a local .env filter
```
DB_user=<you>
DB_password=password
DB_database=bjjtech
DB_port=5432
DB_host=localhost
DB_ssl=false
BJJT_API_ROOT_URL=http://localhost
BJJT_WEB_ROOT_URL=http://localhost
```

### Run it locally
```
NODE_DEBUG=request nf start
```

## Option B: Heroku Installation
This assumes the latest buildpack in Heroku is called “heroku-18.” These buildpacks deprecate over time, so Google what’s the latest.
```
heroku create --remote heroku-18 --stack heroku-18 <your unique heroku app name>
heroku addons:create --remote heroku-18 heroku-postgresql:hobby-dev
heroku addons:create --remote heroku-18 papertrail:choklad
heroku addons:create --remote heroku-18 auth0:free
```
Create config variables in your new Heroku app. Go to Settings->Reveal config variables:
```
BJJT_API_ROOT_URL=http://<your unique Heroku app name>.herokuapp.com
BJJT_WEB_ROOT_URL=http://<your unique Heroku app name>.herokuapp.com
NODE_ENV=production
```
Go to Postgresql config->Settings->reveal credentials to get the psql command to connect and import the database from command line
```
cd sql
psql postgres://<user>:<password>@ec2-54-163-251-104.compute-1.amazonaws.com:5432/<database> < bjjt_schema_data.sql
```
Note, the bjjt_schema_data.sql file has an important order:
1. Create schema
2. Import data
3. Set constraints.
Doing this in a different order, you’ll get a bunch of constraint violations when importing data.
If you visit your PostgreSQL datastore page in Heroku, you should see at least 984 rows of data.
```
git push <your unique heroku app name> master
```
If the build succeeds you're good to go.

### Run it on Heroku
Browse to http://<your unique Heroku app name>.herokuapp.com

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## History


### Original
This was written as a ASP.NET app back in the mid-2000s. Dave hosted it on an old Dell server at his house. When it finally died some 11 years later, he decided to update it and build a node.js version with an EJS front-end.

## Credits

davecthomas

## License
MIT
