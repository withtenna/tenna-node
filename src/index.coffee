request = require 'request'

base_url = 'http://api.tenna.io'

createEvent = (device_id, kind, data, api_key, cb) ->
    request.post
        url: "#{base_url}/devices/#{device_id}/events/#{kind}.json"
        json: data
        headers: {
            'api_key': api_key
        }
    , (err, resp, body) ->
        cb err, body

module.exports = ({api_key, device_id}) ->
    createEvent: (kind, data, cb) ->
        createEvent(device_id, kind, data, api_key, cb)
