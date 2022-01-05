name 'kiosk'
description 'installs a bus info board kiosk'
run_list 'recipe[pacman]',
         'recipe[sudo]',
         'recipe[bib_config]',
         'recipe[kiosk_user]',
         'recipe[fullscreen_chrome]'

override_attributes(
  fschrome: {
    user: 'transit'
  }
)
