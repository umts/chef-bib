# frozen_string_literal: true

require 'cgi'

module BIB
  # Bus Info Board cookbook query-string helpers.
  module QueryString
    extend self

    # Take in a hash of values (probably `node['bib'].to_hash`) and
    # return a formatted query string
    def build_qs(params)
      params.dup.tap { |p| special_case_keys(p) }
            .tap     { |p| delete_keys(p) }
            .tap     { |p| escape_keys(p) }
            .then    { |p| stringify(p) }
    end

    def delete_keys(hash)
      %w[base_url sort_by_time].each { |key| hash.delete(key) }
      hash
    end

    def escape_keys(hash)
      hash.transform_values! do |value|
        value.is_a?(Array) ? escape_array(value) : escape(value)
      end
    end

    def special_case_keys(hash)
      hash.delete('routes') if hash['routes'] == 'all'
      hash['sort'] = 'time' if hash['sort_by_time']
    end

    def stringify(hash)
      hash.map { |k, v| "#{k}=#{v}" }.join('&')
    end

    def escape(value)
      CGI.escape(value.to_s).gsub('+', '%20')
    end

    def escape_array(array)
      array.map { |a| escape(a) }.join('+')
    end
  end
end
