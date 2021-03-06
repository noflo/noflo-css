noflo = require 'noflo'
baseDir = 'noflo-css'

describe 'SetElementTop component', ->
  c = null
  element = null
  top = null
  out = null
  before (done) ->
    @timeout 4000
    loader = new noflo.ComponentLoader baseDir
    loader.load 'css/SetElementTop', (err, instance) ->
      return done err if err
      c = instance
      element = noflo.internalSocket.createSocket()
      c.inPorts.element.attach element
      top = noflo.internalSocket.createSocket()
      c.inPorts.top.attach top
      done()
  beforeEach ->
    out = noflo.internalSocket.createSocket()
    c.outPorts.out.attach out
  afterEach ->
    c.outPorts.out.detach out
    out = null

  describe 'receiving an element and value', ->
    it 'should update element properties', (done) ->
      el = document.getElementById 'setelementtop'
      unless el
        return done new Error 'Fixture not available'
      out.on 'data', ->
        chai.expect(el.style.position).to.equal 'absolute'
        chai.expect(el.style.top).to.equal '10px'
        done()
      element.send el
      top.send 10
