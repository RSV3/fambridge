In order to create new article
==============================

1. Create an entry in contents.yml (test/fixtures/contents.yml)
- You will be using the slug that you defined in file names for views and images

2. Create a view file (app/views/content/<category>/<slug>.html.erb)

3. Add images under app/assets/images/content
- Image file names should start with slug and have following suffixes

- List of suffixes:
  - homepage-article.jpg
  - category-article.jpg
  - article-main.jpg
  - related-article.jpg

4. Update the database by loading the fixture
- Note: you need to be in terminal in the fambridge project directory

$ rake db:fixtures:load

5. Run the web server to test locally

$ rails s

6. http://localhost:3000 will put you on content main page

Git Remote Setup
================

You have to do this only once on your fambridge directory on your local machine.  These two commands will setup configuration to push code updates to the heroku staging and production servers.

$ git remote add staging git@heroku.com:fambridge-staging.git
$ git remote add live git@heroku.com:fambridge-prod.git


If multiple people edited from different machines
=================================================

You need to synchronize the changes which consists of series of git commands.  It is a good practice to do a pull from github before starting to make any changes to get updates that might have been changed by others.


1. See what files have changed so that you can commit

$ git status

2. If any file has been deleted you have to run

$ git add -u

3. If files have been added or edited, add all files in current directory using the following command

$ git add .

4. If you run "git status" you can see all of the files that are ready to be committed

5. Run commit to commit your changes to your local repository (on your machine)

$ commit -m "new you know you are caregiver if article added --skip-ci"

6. Push your changes to github (assuming you are pushing to the develop branch)

$ git push origin develop





Deploying to server
===================

1. Push your chnages to staging server (git remote staging must be setup ahead of time).  You are pushing your local develop branch to master branch on heroku staging server.

$ git push staging develop:master

2. Push your changes to production server (git remote live must be setup ahead of time). You are pushing your local develop branch to master branch on heroku production server.

$ git push live develop:master
