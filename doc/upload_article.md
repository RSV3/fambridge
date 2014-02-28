In order to create a new article
================================

1. Create an entry in contents.yml (directory => test/fixtures/contents.yml)
  - Remember the slug that you specify for each entry since the slug is used in the file names for views and images

2. Create a view file (directory => app/views/content/<category>/<slug>.html.erb)

3. Add images under directory => app/assets/images/content
  - Image file names should start with slug and have following suffixes
  - List of suffixes:
    - -homepage-article.jpg
    - -category-article.jpg
    - -article-main.jpg
    - -related-article.jpg

4. If you need to add images in the body of the article, add a folder under `app/assets/images/content` that is named after the article slug.  Add all the images in that directory.
  - In the article view you can add the image with the following tag

```
    <%= image_tag "content/<slug-name>/<image-file-name>" %>
```

5. Update the database by loading the fixture
  - Note: you need to be in terminal in the fambridge project directory

```
    $ rake db:fixtures:load
```

6. Run the web server to test locally.

```
    $ rails s
```    

7. Enter http://localhost:3000 on your browser which will load the content main page.  

8. If the page shows PG (postgres database connection) error, you need to `ctrl-c` on the terminal and restart `rails s`

Git Remote Setup
================

You have to do this only once on your fambridge directory on your local machine.  These two commands will setup configuration to push code updates to the heroku staging and production servers.  It creates the `staging` and `live` remotes.

    $ git remote add staging git@heroku.com:fambridge-staging.git
    $ git remote add live git@heroku.com:fambridge-prod.git


If multiple people edited from different machines
=================================================

All examples here assume that you are on develop branch.  You can switch to another existing branch

    $ git checkout <branchname>

Or in order to create a new branch:
  
    $ git checkout -b <branchname>


You need to synchronize the changes which consists of series of git commands.  It is a good practice to do a pull from github before making any changes to get updates that might have been changed by others.

1. Pull latest from github

```
    $ git pull origin develop
```

2. Make changes you want to make

3. See what files have changed so that you can commit

```
    $ git status
```

4. If any file has been deleted you have to run

```
    $ git add -u
```

5. If files have been added or edited, add all files in current directory using the following command

```
    $ git add .
```

6. If you run `git status` you can see all of the files that are ready to be committed.  
  
```
    $ git status
```

7. Run commit to commit your changes to your local repository (on your machine).  Make sure to add `--skip-ci` at the end of commit message if you do not want to run a continuous integration job.  Most of the time content changes shouldn't require continuous integration job.

```
    $ commit -m "new you know you are caregiver if article added --skip-ci"
```

8. Push your changes to github so others can incorporate your changes (assuming you are pushing to the develop branch)

```
    $ git push origin develop
```


Deploying to server
===================

1. Push your changes to staging server (git remote `staging` must be setup ahead of time).  You are pushing your local develop branch to master branch on heroku staging server.

```
    $ git push staging develop:master
```

2. Push your changes to production server (git remote `live` must be setup ahead of time). You are pushing your local `develop` branch to master branch on heroku production server.

```
    $ git push live develop:master
```

