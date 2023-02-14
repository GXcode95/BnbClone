This app was created for a tech test, i had to create an AirBnb clone with rails in ~4 hours.
To run with Docker:
  ```
    cp .env.docker.example .env
    docker compose build
    docker compose run --rm web bin/rails db:setup
    dc up
  ```
To run without docker:
  ```
    cp. env.evample .env
    bundle install
    rails db:create db:migrate
    bin/dev 
  ```
  and in an other terminal run 
  ```
   rails s
  ```
  
  If you want the bin/dev script to run `rails s` too juste uncomment the first line of `Procfile.dev`
  
