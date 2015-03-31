name 'test'
description 'installs a bus info board kiosk and its test harness'
run_list 'role[kiosk]'

override_attributes(
  authorization: {
    sudo: {
      users: ['vagrant'],
      passwordless: 'true'
    }
  },
  fschrome: {
    options: ['--remote-debugging-port=9753']
  }
)
