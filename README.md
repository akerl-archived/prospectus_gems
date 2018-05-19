prospectus_gems
=========

[![Gem Version](https://img.shields.io/gem/v/prospectus_gems.svg)](https://rubygems.org/gems/prospectus_gems)
[![Build Status](https://img.shields.io/circleci/project/akerl/prospectus_gems.svg)](https://circleci.com/gh/akerl/prospectus_gems)
[![Coverage Status](https://img.shields.io/codecov/c/github/akerl/prospectus_gems.svg)](https://codecov.io/github/akerl/prospectus_gems)
[![Code Quality](https://img.shields.io/codacy/c5623564a4034ece993510d28edb19de.svg)](https://www.codacy.com/app/akerl/prospectus_gems)
[![MIT Licensed](https://img.shields.io/badge/license-MIT-green.svg)](https://tldrlegal.com/license/mit-license)

[Prospectus](https://github.com/akerl/prospectus) helpers for checking Ruby gem dependency status.

## Usage

Add the following 2 lines to the .prospectus:

```
## Add this at the top
Prospectus.extra_dep('file', 'prospectus_gems')

## Add this inside your item that has a gemspec
extend ProspectusGems::Gemspec.new
```

## Installation

    gem install prospectus_gems

## License

prospectus_gems is released under the MIT License. See the bundled LICENSE file for details.

