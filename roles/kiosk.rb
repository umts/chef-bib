name 'kiosk'
description 'installs a bus info board kiosk'
run_list 'recipe[sudo]'

override_attributes(
  authorization: {
    sudo: {
      users: ['vagrant'],
      passwordless: 'true'
    }
  }
)
