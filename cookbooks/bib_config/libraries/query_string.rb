require 'uri'

module BIB
  # Bus Info Board cookbook query-string helpers.
  module QueryString
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
          qp[key] = value.join('+')
        when 'sort_by_time'
          qp['sort'] = 'time' if value
        when 'routes'
          qp[key] = value.join('+') unless value.to_s == 'all'
        else
          qp[key] = value unless value.nil?
        end
      end

      URI.escape(qp.map { |k, v| "#{k}=#{v}" }.join('&'))
    end
  end
end
