request = require 'request'

base_url = 'http://api.tenna.io'

Tenna = ({api_key, device_id}) ->

    default_headers = {
        'api-key': api_key
        'user-agent': 'Tenna API client'
    }

    createEvent: (kind, data, cb) ->
        request.post
            url: "#{base_url}/devices/#{device_id}/events/#{kind}.json"
            json: data
            headers: default_headers
        , (err, resp, body) ->
            cb err, body

    sendCommand: (method, args..., cb) ->
        request.post
            url: "#{base_url}/devices/#{device_id}/commands/#{method}.json"
            json: args
            headers: default_headers
        , (err, resp, body) ->
            cb err, body

    getDevice: (cb) ->
        request.get
            url: "#{base_url}/devices/#{device_id}.json"
            headers: default_headers
            json: true
        , (err, resp, body) ->
            cb err, body

    getState: (cb) ->
        request.get
            url: "#{base_url}/devices/#{device_id}/state.json"
            headers: default_headers
            json: true
        , (err, resp, body) ->
            cb err, body

module.exports = Tenna
