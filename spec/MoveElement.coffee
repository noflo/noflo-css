noflo = require 'noflo'
baseDir = 'noflo-css'

describe 'MoveElement component', ->
  c = null
  element = null
  point = null
  out = null
  before (done) ->
    @timeout 4000
    loader = new noflo.ComponentLoader baseDir
    loader.load 'css/MoveElement', (err, instance) ->
      return done err if err
      c = instance
      element = noflo.internalSocket.createSocket()
      c.inPorts.element.attach element
      point = noflo.internalSocket.createSocket()
      c.inPorts.point.attach point
      done()
  beforeEach ->
    out = noflo.internalSocket.createSocket()
    c.outPorts.out.attach out
  afterEach ->
    c.outPorts.out.detach out
    out = null

  describe 'receiving an element and value', ->
    it 'should update element properties', (done) ->
      el = document.getElementById 'moveelement'
      unless el
        return done new Error 'Fixture not available'
      out.on 'data', ->
        chai.expect(el.style.position).to.equal 'absolute'
        chai.expect(el.style.top).to.equal '20px'
        chai.expect(el.style.left).to.equal '42px'
        done()
      element.send el
      point.send
        x: 42
        y: 20
