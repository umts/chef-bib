BIB Config Cookbook
===================
This cookbook contains primarily attributes. It's primary purpose is to
build (and override) the URL used in the 'fullscreen\_chrome' cookbook

Requirements
------------
Said 'fullscreen\_chrome' cookbook

Attributes
----------
Note that the `config/bib.yml` file in the bib-chef repository will get
parsed for 'bib' attributes as well.  This is to allow easy
configuration via Rake for the settings that are likely to change from
device to device.

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['bib']['stops']</tt></td>
    <td>Array</td>
    <td>An array of stop ids to show</td>
    <td><tt>[1]</tt></td>
  </tr>
  <tr>
    <td><tt>['bib']['routes']</tt></td>
    <td>Array or <tt>:all</tt></td>
    <td>An array of routes to limit display to.  The symbol
      <tt>:all</tt> is also allowed</td>
    <td><tt>:all</tt></td>
  </tr>
  <tr>
    <td><tt>['bib']['excluded_trips']<tt></td>
    <td>Array</td>
    <td>An array of trip destinations to hide from display</td>
    <td><tt>['Bus Garage via Mass Ave', 'Bus Garage via Compsci']</tt></td>
  </tr>
  <tr>
    <td><tt>['bib']['sort_by_time']</tt></td>
    <td>Boolean</td>
    <td>Whether to sort departures by time rather than the default,
      route</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['bib']['interval']</tt></td>
    <td>Integer</td>
    <td>The number of seconds to wait before refreshing</td>
    <td><tt>30</tt></td>
  </tr>
  <tr>
    <td><tt>['bib']['work_start_day']</tt></td>
    <td>Integer</td>
    <td>The hour that a service day begins</td>
    <td><tt>4</tt></td>
  </tr>
  <tr>
    <td><tt>['bib']['start_animation']</tt></td>
    <td>String</td>
    <td>A named animation to use on data load</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['bib']['end_animation']</tt></td>
    <td>String</td>
    <td>A named animation to use on data unload</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['bib']['title']</tt></td>
    <td>String</td>
    <td>A title to show as a header for the departures</td>
    <td><tt>'Bus Departures'</tt></td>
  </tr>
</table>

License and Authors
-------------------
Authors: Matt Moretti
