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

Setup an application with Github and setup some environment variables

```
ENV['GITHUB_CLIENT_ID']
ENV['GITHUB_CLIENT_SECRET']
```

Only admin users are allowed create or edit existing outlines.