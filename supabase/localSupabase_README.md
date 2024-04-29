## Develop locally
To setup and connect to a local instance of supabase do the following.:

Start by ensuring that Supabase CLI is installed on your computer.

This can be done on Mac by homebrew like this:
```shell
brew install supabase/tap/supabase
```

Ensure that you have docker running.

Then run following command in your terminal:
```shell
supabase login
```
This will open a window in your browser, and create a token. You have to do nothing.

Finally run:
```shell
supabase start
```

This will run a local supabase in a dockercontainer.

### Make the local db up to date with the remote

Before making changes to the local db, make sure that it has the lates migration
as the remote db. Do this by first by linking the local db to the remote:

```shell
supabase link --project-ref <project-id>
```
You can get <project-id> from the project's dashboard URL: https://supabase.com/dashboard/project/<project-id>

Now you can pull the changes to the remote db down to your local db, by running:
```shell
supabase db pull
```

### Running the project with the local db

When running the project, give it the following flags:

```shell
flutter run --dart-define=SUPABASE_URL=<API URL> --dart-define=SUPABASE_ANONKEY=<ANON KEY>
```
API URL and ANON KEY, is printed in your terminal when running the command from above.

(ONLY NECESSARY FOR RUNNING UI PART OF APP)
In order to create a user for our app inside Supabase. Go to the URL for Supabase Studio. (Also printed in terminal).
Navigate to Authentication -> Add user. 

This ensures that you are able to login on the admin app.

## Migration of DB
You can use the local studio URL to browse the Supabase dashboard, and make changes in tables etc.

After creating changes you save these to migrations by running following command from the root of the project.

```shell
supabase db diff --use-migra -f <name of migration>
```

If you want these changes to go up to the remote db, you can push the migrations with:
```shell
supabase db push
```