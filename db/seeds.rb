user_names = %w[ DEFAULT_USER_NAME allen chris ]
users = user_names.map do |name|
  [name, User.create!(name: name)]
end.to_h


users["allen"].follow! users["DEFAULT_USER_NAME"].id
users["allen"].follow! users["chris"].id

users["DEFAULT_USER_NAME"].follow! users["allen"].id
users["DEFAULT_USER_NAME"].follow! users["chris"].id

now = Time.now.utc
7.times do |i|
  users["DEFAULT_USER_NAME"].log_sleep! at: now - 3.hours
  users["DEFAULT_USER_NAME"].log_wake_up! at: now + 5.hours
end
