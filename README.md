# bjjtechniques

A Brazilian Jiu-Jitsu technique catalog, written in Node.js, EJS, and Javascript.

## Installation

1. Download and install Node.js and npm: https://www.npmjs.com/get-npm. Tested with Node v13.5.0 and npm v6.13.4.
2. npm install
3. If you get a build failure, you may need to install the C runtime libraries: xcode-select --install
4. Install Homebrew: /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
5. Install PostgreSQL: brew install postgresql
6. Start PostgreSQL: pg_ctl -D /usr/local/var/postgres start
7. Import SQL into the DB
8. Create a local .env filter
```
DB_user=
DB_password=
DB_database=
DB_port=5432
DB_host=localhost
DB_ssl=false
BJJT_API_ROOT_URL=http://localhost
BJJT_WEB_ROOT_URL=http://localhost
```

## Usage

TODO: Write usage instructions

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
