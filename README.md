# KSPMaps

> A Google Maps-like UI for Kerbal Space Program (KSP) celestial bodies.

[![CircleCI](https://img.shields.io/circleci/project/github/FiniteMonkeys/ksp-maps.svg?style=flat)](https://circleci.com/gh/FiniteMonkeys/ksp-maps)

## QUICK START

1. Clone the repository.
2. Edit `config/dev.exs` to set up the database connection appropriately.
3. Run `mix deps.get`.
4. Run `mix phx.server`.

Note that image tiles are not included in this repository at the moment.
I need to figure out who has them and by what rights, if any, we're allowed
to use them.

## INSTALLATION

> how to deploy?

## KNOWN BUGS

## CONTRIBUTING

  * Install dependencies with `mix deps.get`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Unit tests were written with [ESpec](https://github.com/antonmi/espec).
Execute the specs by running `mix espec`.

## TODO

> this should probably be broken out to a separate document

  * Convert tests to specs using ESpec
  * Add badges to README.md

## COPYRIGHT

Copyright (c) 2018-2019 Craig S. Cottingham, except where stated otherwise.

## LICENSE

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions
and limitations under the License.