# django-libelektra

This repository is my homework for the university lecture "194.030 Configuration Management" at TU Wien.

## Specification (HW1)

An elektra-specification for the most important Django settings can be found in `spec/django.spec.ni`:

* `ALLOWED_HOSTS`
* `CSRF_TRUSTED_ORIGINS`
* `DATABASE`: `Dict`
  * Key-Value-Pair.
  * Value is another `Dict`:
    * `ENGINE`
    * `NAME`
    * `USER`
    * `PASSWORD`
    * `HOST`
    * `PORT`
* `DEBUG`
* `INSTALLED_APPS`

Django's license can be found [here](https://github.com/django/django/blob/main/LICENSE).

Specification for Django's settings can be found [here](https://docs.djangoproject.com/en/4.0/ref/settings/).

## Run it (H2)

1. Mount specification and apply test data: `./spec/test-spec.sh`
2. Create venv and install requirements:
   1. `python3 -m venv venv`
   2. `./venv/bin/pip install -r requirements.txt`
3. Migrate data `./venv/bin/python3 manage.py migrate`
4. Run server: `./venv/bin/python3 manage.py runserver`
