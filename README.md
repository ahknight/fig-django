# Django Configuration for `fig`

This is a simple setup to create a configuration in `fig` that uses Postgres and Nginx.

The only known limitation is that the Postgres container's data is effectively trapped within the Docker filesystem and exporting it as a volume tends to anger Postgres (especially over `boot2docker`).  It is, however, trivial to setup a cron job that backs up the database.

Some backup suggestions:

- `fig run db pg_dump --host db --user postgres > dump.sql`
- `fig run app python manage.py dumpdata [options] > dump.json`
- `docker export [container_name]` (this gets the whole filesystem as a tar file)
- `docker commit [container_name] [repo:tag]` (keeps a copy of the current filesystem in Docker)

## Requirements

Very few.  By default it presumes your Django project is using either South prior to Django 1.7 or Django 1.7 as the startup script for the `app` container runs `manage.py migrate`, but that's easily altered not only to use `syncdb` or to run a different server such as `gunicorn` or `uwsgi`.

## Setup

The `manage.py` and `requirements.txt` files are expected to be in `app`.  If that doesn't work for you, poke around `app/DockerStart.sh` and `app/Dockerfile` for the places to change that.

There is a demonstation Django 1.7 app in `app` already so this so you can technically run `fig up` without anything else just to see it work, but you might want to use this with a real application eventually, so here's how:

1. Checkout a copy of this and `cd` into it.
2. Either run `django-admin.py startproject [projectname] app` or checkout an existing project into `app`.   
3. Update the `DJANGO_SETTINGS_MODULE` in `fig.yml`.
4. Run `fig up`.

After a lot of console spew, you should be able to go to the IP of the host and see something on port 80.  If not, figure it out and submit an issue or pull request if it's not an issue with your Django app. :)
