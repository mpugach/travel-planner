## An example of Ember SPA with Rails API

### Setup and start development server

1. Start PostgreSQL server
2. `cd backend`
3. `cp config/database.yml.template config/database.yml # and edit it`
4. `bundle install`
5. `rake db:setup`
6. `rails s`
7. `cd frontend`
8. `npm install`
9. `npm install -g bower`
10. `npm install -g phantomjs-prebuilt`
11. `bower install`
12. `brew install watchman`
13. `npm start`

open [localhost:4200](http://localhost:4200) in browser

#### Run backend tests and linters
```bash
cd backend
rubocop
rspec
```

#### Run frontend tests and linters

open [localhost:4200/tests](http://localhost:4200/tests) in browser

#### Generate API docs

```bash
cd backend
rake docs:generate
```

open backend/doc/index.html
