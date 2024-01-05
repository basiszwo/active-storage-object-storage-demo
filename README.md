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

## Solution

See https://github.com/rails/rails/issues/50583

```ruby
# config/initializers/active_storage_blob_purge_patch.rb

# Ensure variants are deleted only if variants tracking is disabled
# This is needed because ActiveStorage::PurgeJob fails if variants are tracked
# but also fails if variants are not tracked. The latter also keeps files in
# the variants folder which are basically stale.
# see https://github.com/rails/rails/issues/50583
Rails.application.config.to_prepare do
  logger = Rails.logger
  logger.info "Loading Active Storage Blob Purge Patch ..."

  class ActiveStorage::Blob < ActiveStorage::Record
    def delete
      service.delete(key)
      service.delete_prefixed("variants/#{key}/") if image? && !ActiveStorage.track_variants
    end
  end
end
```
