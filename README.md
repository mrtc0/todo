# todo

---

[![CircleCI](https://circleci.com/gh/mrtc0/todo.svg?style=svg)](https://circleci.com/gh/mrtc0/todo)

https://github.com/everyleaf/el-training をやっている

---

- Ruby 2.5.1
- Rails 5.2.0
- PostgreSQL

### development

```shell
docker-compose build
docker-compose up
docker-composer run app rails db:setup
docker-composer run app rails s -b 0.0.0.0
```

### deploy

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy?template=https://github.com/mrtc0/todo)

```shell
# 初回のみ
# heroku run rails db:migrate
git push heroku master
```
