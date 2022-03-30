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
