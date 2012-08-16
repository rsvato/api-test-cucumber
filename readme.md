Genesis cucumber tests
======================

You should have ruby installed with following gems:

- Cucumber
- HTTParty

Copy config.yml.sample to config.yml and edit it to reflect your settings:

```yaml
genesis:
  host: 127.0.0.1 #host running genesis
  port: 8080 #port that genesis listen on
  user: user #user to use for tests
  password: pass #pass to use for tests
```

Expectations
------------

- Template Simple.genesis in subdir templates should be accessible for genesis instance
