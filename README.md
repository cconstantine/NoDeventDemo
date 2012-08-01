# NoDevent Demo

This is a demo project for http://github.com/cconstantine/NoDevent .

# How to use
## Prerequisites
I'm assuming you have a working postgress, redis, and ruby install running on a unix-like OS.

## Use it
1) Install node (http://nodejs.org)
2) Start nodevent
```shell
npm install -g nodevent
npm start nodevent
```
3) Clone the repo
```shell
git clone https://github.com/cconstantine/NoDeventDemo.git
cd NoDeventDemo
```

4) Do the rails things
```shell
bundle install
rake db:setup
bundle exec rails s
```
