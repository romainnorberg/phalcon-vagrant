# Vagrant Phalcon

Original from https://github.com/phalcon/vagrant

```
$ git clone https://github.com/romainnorberg/phalcon-vagrant.git
...
$ cd phalcon-vagrant
...
$ vagrant up
...
$ vagrant ssh
```

#### Add to your /etc/hosts:
```
192.168.50.9    uuid.dev
```

#### Don't work ?
run
```php --re Phalcon | grep version```
and also check vagrant build log to find errors

### Apps

#### 1) app test use UUID with Mysql

http://uuid.dev/

Inspiration:
```

- http://stackoverflow.com/a/30462400/3693616
- http://kekoav.com/posts/uuid-primary-key-mysql
- https://docs.phalconphp.com/en/latest/api/Phalcon_Security_Random.html
- https://forum.phalconphp.com/discussion/1603/get-id-uuid-short-after-create-model
- https://www.youtube.com/watch?v=8O-IeLRgsCI #Bonnes pratiques de déploiement PHP en 2015 - Quentin Adam #phptour 34:58 | 41:18
```
#### 2) app test with profiler

...Soon...
