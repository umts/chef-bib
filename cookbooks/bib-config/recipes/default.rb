#
# Cookbook Name:: bib-config
# Recipe:: default
#
# Copyright 2015, UMass Transit Service
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
require 'uri'

query_params = node['bib'].to_hash.reject { |_, v| v.nil? }

query_params.delete('username')

query_params['stops'] = query_params['stops'].join('+')
query_params['excluded_trips'] = query_params['excluded_trips'].join('+')
query_params['sort'] = 'time' if query_params.delete('sort_by_time')

if query_params['routes'].to_s == 'all' || query_params['routes'].nil?
  query_params.delete('routes')
end

query_string = URI.escape(query_params.map { |k, v| "#{k}=#{v}" }.join('&'))

node.normal['fschrome']['url'] = "http://umts.github.io/BusInfoBoard/?#{query_string}"

log 'bib_address' do
  message "set Chrome URL to: #{node['fschrome']['url']}"
  level :info
end
