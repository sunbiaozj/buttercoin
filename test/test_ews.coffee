describe 'EWS', ->

  it 'should listen and be connectable', (finish) ->
    stump.info('HAI!')

    EngineWebsocketServer = require('../lib/ews/engine_websocket_server')
    WebsocketInitiator = require('../lib/ews/websocket_initiator')

    engine_server = new EngineWebsocketServer()
    engine_server.start().then =>
      stump.info('started')

      wsi = new WebsocketInitiator( {wsconfig: 'ws://localhost:6150/'} )
      wsi.connect().then =>
        wsi.execute_operation(
          {
            kind: "ADD_DEPOSIT"
            account: "peter"
            amount: "5"
            currency: 'BTC'
          }
        ).then (retval) =>
          stump.info 'GOT RETVAL', retval

          engine_server.stop().then =>
            finish()
      .done()