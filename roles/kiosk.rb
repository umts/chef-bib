name 'kiosk'
description 'installs a bus info board kiosk'
run_list 'recipe[sudo]',
         'recipe[kiosk_user]'

override_attributes(
  authorization: {
    sudo: {
      users: ['vagrant'],
      passwordless: 'true'
    }
  }
)
