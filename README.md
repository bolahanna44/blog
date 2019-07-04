# Blog

a simple blog application with oAuth enabled for user registration and login and integrate 2 factor
authentication for posts. Integrate 2FA using Twillio Authy app & SMS.

## System Requirements

* Mysql
* Ruby 2.6.0
* Rails 5.2.3
* Node >= 11.12.0

## Installation
in the app directory run the following commands

1. `bundle`
2. `yarn`
3. cp config/database.yml.example config/database.yml
4. configure config/database.yml with your configuration
5. `rails db:create db:migrate`
6. run `EDITOR=nano bin/rails encrypted:edit config/credentials.yml.enc`
7. append the following keys to your file  
```
 authy_key: xxx
 facebook_client_id: xxx
 facebook_client_secret: xxx
 google_client_id: xxxx
 google_client_secret: xxx
```

8. edit edit config/storage.yml with your
google cloud storage configuration
9. run foreman s
10. open http://localhost:3000 ;) 


## Deployment
on the server do the following

1. install ImageMagick by running `sudo apt install imagemagick`
3. install Redis by running the following 
`sudo apt-get install redis-server`
4. ensure it is installed properly by running 
`sudo ps aux | grep redis`


in you project directory do the following 

1. put you server ip address and deploy username to 
    config/deploy/production.rb
2. run `cap production deploy`

you will encounter error that master.key and database.yml is not found in the shared directory
so do the following in the server 

1. add master.key by running the following 
`sudo cat your-local-master-key-here >> /home/username/apps/blog/shared/config/master.key`
2. add Google cloud storage key by running 
`sudo nano /home/username/apps/blog/shared/config/keys/gcs_key.json`
3. paste your json object you get from google then ctrl + x to save the file 
4. add database configuration with the same way
  `sudo nano /home/username/apps/blog/shared/config/database.yml`

after you add those files run `cap productiopn deploy`
in you local app directory and it will run successfully
this time  