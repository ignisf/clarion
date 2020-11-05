Clarion
=======

A CfP automation system for OpenFest.

Installation
------------

1. `git clone https://github.com/ignisf/clarion.git`
2. Run `bundle install; bin/rake bootstrap`
3. You can now run the rails server with `bin/rails s`

Usage with Docker
-----------------

Requires [Docker](https://www.docker.com/) and [Docker Compose](https://docs.docker.com/compose/).

1. Run `git clone https://github.com/ignisf/clarion.git`.
2. Run `docker-compose up --build --detach`.
3. Add `127.0.0.1 clarion.openfest.test` to your system's host file.
4. Open http://clarion.openfest.test:3000/management in your browser and log in with username `foo@example.com` and password `123qweASD`.