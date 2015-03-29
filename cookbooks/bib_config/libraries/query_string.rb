require 'uri'

module BIB
  module QueryString
    def build_qs(params)
      qp = {}
      params.each do |key, value|
        case key
        when 'base_url'  #Delete
        when 'stops', 'excluded_trips'  #Arrays
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
