name 'kiosk'
description 'installs a bus info board kiosk'
run_list 'recipe[pacman]',
         'recipe[sudo]',
         'recipe[kiosk_user]',
         'recipe[fullscreen_chrome]'

override_attributes(
  authorization: {
    sudo: {
      users: ['vagrant'],
      passwordless: 'true'
    }
  },
  pacman: {
    build_user: 'nobody'
  },
  fschrome: {
    user: 'transit'
  }
)
