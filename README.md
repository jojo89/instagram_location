# Url Shortener

##dependencies
* Ruby version ruby "2.2.1"

### Development

from the directory you would like to store the project.

```
$ git clone git@github.com:jojo89/instagram_location.git
```

```
$ cd instagram_location
```

```
$ bundle install
```

add these lines to your ```~/.bashrc``` file
```
export CLIENT_ID=your_instagram_client_id
export CLIENT_SECRET=your_instagram_secret_key
```

```
$ shotgun
```
 
 Your Application will be available at localhost:9393
 
### Test

 to run all specs 
```
$ bundle exec rspec
```
to run an individual spec do the same,but add the file extentsion

 i. e.
```
$ bundle exec rspec spec/models/instagram_location_fetcher_spec.rb
```

### production

project is hosted at http://instagram-by-city.herokuapp.com/


### Notes 
  This is a simple sinatra app that makes queries to the instagram api based on a location that passed from the user.
  The front-end is written in angular that displays a list of the top instagram records for the given area. It updates 
  features the tweet in the profile directive when the user clicks on the list item. The banner updates with the name of the location that is being searched. 
  there is no database the instagram response is simply parsed for the attributes that are important to the 
  front-end and sorted by thier like count.





