# Django Configuration for `fig`

This is a simple setup to create a configuration in `fig` that uses Postgres and Nginx.

The only known limitation is Postgresql's data is effectively trapped within the Docker filesystem and exporting it as a volume tends to anger Postgres (especially over `boot2docker`).  It should be trivial to setup a cron job that backs up the database.

Some backup suggestions:

- `fig run db pg_dump [options]`
- `fig run app python manage.py dumpdata [options] > dump.json`
- `docker export [container_name]` (this gets the whole filesystem as a tar file)
- `docker commit [container_name] [repo:tag]` (keeps a copy of the current filesystem in Docker)


## Requirements

Very few.  By default it presumes your Django project is using either South prior to Django 1.7 or Django 1.7 as the startup script for the `app` container runs `manage.py migrate`, but that's easily altered not only to use `syncdb` or to run a different server such as `gunicorn` or `uwsgi`.

## Setup

1. Checkout a copy of this.
2. Either `cd` into `app` and `django-admin.py startproject` or checkout an existing project into `app`.
3. From the root of this repo, run `fig up`.
