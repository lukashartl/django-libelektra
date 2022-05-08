# django-libelektra

This repository is my homework for the university lecture "194.030 Configuration Management" at TU Wien.

## What is this?

This is a proof of concept for "elektrify" Django.

This Django Project uses [libelektra](https://github.com/ElektraInitiative/libelektra) for storing it's settings.

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

## Sample Application (HW2)

### Installation

Since this is a very generic python project, installation is very easy:

1. Checkout source code

   ```sh
   git clone ...
   ```

2. Create a new [virtual environment](https://docs.python.org/3/library/venv.html) named `venv` with system site packages:

   ```sh
   python3 -m venv venv --system-site-packages
   ```

3. Install requirements:

   ```sh
   ./venv/bin/pip install -r requirements.txt
   ```

### Running

1. Mount specification and apply test data:

   ```sh
   ./spec/test-spec.sh
   ```

2. initialize db and apply migrations:

   ```sh
   ./venv/bin/python3 manage.py migrate
   ```

3. Run server:

   ```sh
   ./venv/bin/python3 manage.py runserver
   ```

### Testing

Open <http://127.0.0.1:8000> in your browser for the hello world page, or <http://127.0.0.1:8000/admin> for the admin console.

If you want to access django admin, you have to create a superuser first: `python manage.py createsuperuser`.

### Need Help for HW3?

You'll find my contact data in the private `cm2022s` repository.

## Ansible Setup (HW3 - Philipp Leeb)

### Installation

1. Install ansible:  

    ```sh
    pip3 install ansible
    ```

### Running

1. Run playbook:

    ```sh
    ansible-playbook philippleeb/setup-playbook.yml --ask-become-pass
    ```

2. Move to the directory:

    ```sh
    cd ~/django-libelektra
    ```

3. Run application:

    ```sh
    ./venv/bin/python3 manage.py runserver
    ```

### Properties

#### Idempotence

Is guaranteed by ansible for all inbuilt functions and the scripts also only use idempotent functions (for example: KDB set).
The mount is checked in the playbook as well so that the mount setup is only done if it does not exist.

#### Only partial changes

This is by default done by ansible inbuilt functions. The same conzept is implemented with the "check kdb mounts", where the mounts are only executed, if they do not exist.

#### Self description

The titles of the tasks should give a brief idea what is done by them.

#### Round tripping

This is guaranteed by the kdb commands which are used in the shell-script.

#### Error handling

Ansible handles errors by stopping the specified chain, if there are critical failures.
In the case of mounts, the "check kdb mounts" task prevents errors in the "mount and configure" task.

## Issues while developing

- Wrong python version which was not compatible with the setup (3.10) -> Downgrade to python 3.9