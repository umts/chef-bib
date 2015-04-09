require 'cgi'

module BIB
  # Bus Info Board cookbook query-string helpers.
  module QueryString
    extend self
    # Take in a hash of values (probably `node['bib'].to_hash`) and
    # return a formatted query string
    def build_qs(params)
      qp = {}
      params.each do |key, value|
        case key
        # Delete these keys
        when 'base_url'
        # These keys are arrays, join w/+
        when 'stops', 'excluded_trips'
          qp[key] = escape_array(value)
        when 'sort_by_time'
          qp['sort'] = 'time' if value
        when 'routes'
          qp[key] = escape_array(value) unless value.to_s == 'all'
        else
          qp[key] = escape(value) unless value.nil?
        end
      end

      qp.map { |k, v| "#{k}=#{v}" }.join('&')
    end

    def escape(value)
      CGI.escape(value.to_s).gsub('+', '%20')
    end

    def escape_array(array)
      array.map { |a| escape(a) }.join('+')
    end
  end
end
