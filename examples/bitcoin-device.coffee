somata = require 'somata'
Tenna = require 'tenna-node'

client = new somata.Client

api_key = process.env.API_KEY
device_id = process.env.DEVICE_ID

if !api_key? || !device_id?
    console.log 'Usage: API_KEY=[api_key] DEVICE_ID=[device_id] coffee tenna-poster.coffee'
    process.exit()

tenna_device = Tenna {api_key, device_id}

add = (a, b) -> a + b
sum = (l) -> l.reduce(add, 0)
avg = (l) -> sum(l) / l.length

reportPrice = ->
    client.remote 'bitbot:data', 'findLastTrades', 'bitfinex', 5, (err, trades) ->
        price = avg trades.map (t) -> t.price
        console.log "Last price is", price

        tenna_device.createEvent 'price', {value: price, unit: '$'}, (err, created_event) ->
            console.log "[postPrice] Created event #{created_event._id}"

reportPrice()
setInterval reportPrice, 1000 * 60 * 30
