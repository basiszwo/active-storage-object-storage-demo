# Active Storage Object Storage Demo

This application is to demonstrate the behaviour described in
https://stackoverflow.com/posts/77757586

## use the application

```bash
# copy and adjust .env.example as .env
cp .env.example .env

# setup database
rails db:setup

# start rails server
rails s
```

Go to http://localhost:3000/users and create a user and then destroy it.

Follow the logs to see the error

```bash
ActiveJob] [ActiveStorage::PurgeJob] [c1abff82-b191-4508-b89b-3f2c0dd5c9a6] Error performing ActiveStorage::PurgeJob (Job ID: c1abff82-b191-4508-b89b-3f2c0dd5c9a6) from Async(default) in 122.91ms: Aws::S3::Errors::NoSuchKey (Aws::S3::Errors::NoSuchKey):
```
