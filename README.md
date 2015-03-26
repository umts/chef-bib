A collection of cookbooks using `chef-solo` to configure a [Bus Info
Board][bib] kiosk.

Configuration
=============
Clone (or download) the repository to a base Arch system and then edit
the `config/bib.yml` file. The attributes in this file get merged into
the node attributes when chef runs.  At a minimum, you'll want to set
the stop ids for the site you're deploying.

Setup
=====
Now, simply run the following rake task to start chef solo on its path

```
$ sudo rake bib:install
```

Test-kitchen
============
This repo contains configuration for [test-kitchen][tk]. You can run
some simple integration tests like so:

```
$ kitchen create
$ kitchen converge
$ kitchen verify
$ kitchen destroy
```

[bib]: https://github.com/umts/BusInfoBoard
[tk]: http://kitchen.ci/
