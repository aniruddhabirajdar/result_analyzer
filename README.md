# RESULT ANALYZER RAILS APP

This application works with test results and performs end of day (EOD) and Monthly Calculations.

##### Steps to run application (In application folder)
- Run `% bundle install`
- Run `% rake db:create` and `rake db:migrate`
- Run `% rails s`
- Run `% redis-server` *
- Run `% sidekiq` *

##  Run Test
- `% rspec`
_To excute without redis-server and sidekiq, skip all the tests from spec/jobs/sidekiq_schedululer_spec.rb_

##  Random Testing data 
- ✨ `% rake test_data:dump`  ✨

## API
#### 1. Create Post
```sh
curl --location --request POST 'http://localhost:3000/results_data' \
--header 'Content-Type: application/json' \
--data-raw '{
             "subject": "Science",
             "timestamp": "2022-04-18 12:02:44.678",
              "marks": 123.0

}'
```
Sample Response 
```sh
{
    "id": 14,
    "subject": "Science",
    "timestamp": "2022-04-18T12:02:44.678Z",
    "marks": "123.0",
    "created_at": "2022-07-03T08:49:53.250Z",
    "updated_at": "2022-07-03T08:49:53.250Z"
}
```

_* ALL about Daily and monthly Jobs_

sidekiq schedule YML file path: `config/schedule.yml`

>Here we have used sidekiq-cron queuing libraries to exute jobs on required time. Also we can use os's Crontab to excute these jobs using Rake task, which will be light weight excution

i.e
**On every day at 6 PM: (daily Avrage)**
`0   18 * *   *  cd /Users/you/projects/rails-app && /usr/local/bin/rake RAILS_ENV=<ENV> result_calulation:daily`


**On every third Monday of week at 6 PM: (Monthly Avrage)**
`0   18  15-21 *   *   [ "$(date '+\%u')" = "1" ] && cd /Users/you/projects/rails-app && /usr/local/bin/rake RAILS_ENV=<ENV> result_calulation:monthly`

Usefull commans :
- `crontab -l`
- `crontab -e`

_Download Redis from https://redis.io/_
