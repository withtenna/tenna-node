somata = require 'somata'
Tenna = require 'tenna-node/src'

api_key = process.env.API_KEY
device_id = process.env.DEVICE_ID
is_on = process.argv[2] == 'on'

if !api_key? || !device_id? || !is_on?
    console.log 'Usage: API_KEY=[api_key] DEVICE_ID=[device_id] coffee hue-button.coffee [on/off]'
    process.exit()

tenna_device = Tenna {api_key, device_id}
tenna_device.sendCommand 'setState', {on: is_on}, (err, response) ->
    console.log 'sent?', response

