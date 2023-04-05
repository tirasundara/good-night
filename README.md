# Good Night

## Features
* Clock In operation, and return all clocked-in times, ordered by created time.
* Users can follow and unfollow other users.
* See the sleep records over the past week for their friends, ordered by the length of their
sleep.

## How To Run Locally
* Ensure PostgreSQL is already running
* Adjust config/database.yml according to your DB setup
* Run `bin/rails db:create`
* Run `bin/rails db:migrate`
* Run `bin/rails db:seed`
* Run `bin/rspec spec` to make sure the tests are passed
* Run `bin/rails s`
* Test the `/ping` end point: `curl http://localhost:3000/ping`
* If you get `{"status":"pong"}`, congratiulations your setup is complete!

## Available API end-points
### Follow a User
  * API end-point: `POST /api/v1/user_follows`
  * Request body: `{ "user_follow": { "followee_id": 123 } }`
  * Response body: `{"data": {"id": "4", "type": "user_follow", "attributes": {"id": 4, "follower_id": 1, "followee_id": 3, "created_at": "2023-04-05T17:18:35.452Z"}}}`
  * Response code: 201

### Unfollow a User
  * API end-point: `DELETE /api/v1/user_follows/:followee_id`
  * Request body: `{}`
  * Response body: `{}`
  * Response code: 204

### Sleep Clock-In
  * API end-point: `POST /api/v1/sleep_times`
  * Request body: `{ "sleep_ts": "timestamps" }`
  * Response body: `{"data": {"id": "7", "type": "sleep_time", "attributes": {"id": 7, "sleep_ts": "2023-04-05T14:18:35.455Z", "created_at": "2023-04-05T17:18:35.578Z"}}}`
  * Response code: 201

### Get Current User's Clock-In List
  * API end-point: `GET /api/v1/sleep_times`
  * Response body: `{"data": [{}, ...] }`
  * Response code: 200

### Sleep Clock-Out (Wake up time)
  * API end-point: `POST /api/v1/wake_up_times`
  * Request body: `{ "wake_up_ts": "timestamps" }`
  * Response body: `{"data": {"id": "7", "type": "wake_up_time", "attributes": {"id": 7, "wake_up_ts": "2023-04-05T14:18:35.455Z", "created_at": "2023-04-05T17:18:35.578Z"}}}`
  * Response code: 201

### Get Friends' Sleep Records
  * API end-point: `GET /api/v1/sleep_records`
  * Query params: `?start_date=2023-04-01&end_date=2023-04-07&sort_key=duration&sort_dir=-1`
    * `start_date` is optional. Must be set together with `end_date`
    * `end_date` is optional. Must be set together with `start_date`
    * `sort_key` is optional. Valid values: `["id", "user_id", "created_at", "duration"]`. Default: `"created_at"`
    * `sort_dir` is optional. Valid values: `["asc", "1", "desc", "-1"]`. Default: `"desc"`
  * Response body:
    ```json
    {
      "data": 
        [
          {"id": "1", "type": "sleep_record","attributes": {"id": 1, "user_id": 1, "created_at": "2023-04-05T17:18:35.478Z", "sleep_ts": "2023-04-05T14:18:35.455Z", "wake_up_ts": "2023-04-05T22:18:35.455Z", "duration": 28800}},
          {}, ...
        ]
    }
    ```
  * Response code: 200
