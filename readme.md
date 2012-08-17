Genesis cucumber tests
======================

You should have ruby and rubygems (or jruby) installed.

Steps to run
------------

1. Install bundler:

```
gem install bundler
```

2. Install tests dependencies:

```
budle install
```

3. Copy config.yml.sample to config.yml and edit it to reflect your settings:

```yaml
genesis:
  host: 127.0.0.1 #host running genesis
  port: 8080 #port that genesis listen on
  user: user #user to use for tests
  password: pass #pass to use for tests
```

4. Run tests:

```
bundle exec cucumber
```

or just 

```
cucumber
```

Note: with JRuby commands should be prefixed with

```
jruby -S ...
```


Expectations
------------

- Template Simple.genesis in subdir templates should be accessible for genesis instance
