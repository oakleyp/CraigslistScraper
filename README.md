# Craigslist Scraper 

Interview Assessment: A Rails app that scrapes a given number of listings from Craigslist by URL, and displays them in a sorted table in given increments.

## To start

#### In at least one version of OSx:

In the root directory, **`npm start`** will create the DB, run migrations, start the rails server and open the correct page, by the following bash command:

```rails db:create && rails db:migrate && open http://localhost:3000/listings/create && rails s```

This page may need to be refreshed if it loads before the rails server starts listening.

#### In any other rails environment:

If the above script does not work correctly in your environment, there is a postgreSQL dump of the DB schema in the project root directory named **`cl_listings_dump.sql`** . After building this into a database, the **`config/database.yml`** file may need to be reconfigured with the correct credentials and DB name.

#### Routes:

**`/listings/create`** Scrapes listings with defaults as configured in listings_controller, and redirects to index page. This can be changed quickly to allow url query params if necessary, although not specified in the requirements.

**`/`** Displays all scraped listings in the DB.

