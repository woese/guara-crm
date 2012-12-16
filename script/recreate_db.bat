move spec ~spec~
rake db:drop
rake db:create
rake db:migrate
rake db:test:prepare
rake db:populate
rake db:seed
rake db:seed RAILS_ENV=test
move ~spec~ spec