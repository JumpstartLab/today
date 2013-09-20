== Today

Simple outline management

```
bundle install
createdb today_development
rake db:migrate
rake import
rake pg_search:multisearch:rebuild[Outline]
rails s
```

Setup an application with Github and setup some environment variables in a file
named `.env` in the root of the Rails application

* Create `.env`

* Add the Github Client ID and Github Client Secret

```
GITHUB_CLIENT_ID=abc1234abcabc1234abc
GITHUB_CLIENT_SECRET=abc1234abcabc1234abcabc1234abcabc1234abc
```

Only admin users are allowed create or edit existing outlines.