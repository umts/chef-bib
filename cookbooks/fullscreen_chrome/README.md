Fullscreen Chrome Cookbook
==========================
This cookbook configures the packages required to run chrome(ium) in a
fullscreen, digitial signage mode.  It also (optionally) configures a
user to run said setup on login.

Requirements
------------
The 'pacman' cookbook (for AUR)

Attributes
----------
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['fschrome']['url']</tt></td>
    <td>String</td>
    <td>The url for Chrome to display</td>
    <td><tt>'http://example.com/'</tt></td>
  </tr>
  <tr>
    <td><tt>['fschrome']['user']</tt></td>
    <td>String</td>
    <td>The user who will run chrome on login</td>
    <td><tt>nil</tt></td>
  </tr>
</table>

Usage
-----
`node['fschrome']['user']` defaults to `nil`, so the default behaviour
is to not set up any particular user with this configuration.  Specify a
user in order to set this up.

License and Authors
-------------------
Authors: Matt Moretti
