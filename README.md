This app was created for a tech test, i had to create an AirBnb clone with rails in ~4 hours.
# To run without docker:
  ```
    cp env.evample .env
    bundle install
    yarn install
    rails db:create db:migrate db:seed
    bin/dev
  ```
# Docker:
The app isn't working with docker atm. It seems that assets precompile is not done correctly, I tried some modifications without result. I'm not very used to docker and I would have to stay longer to understand what's going wrong. I could take a look this weekend if you want.
  
