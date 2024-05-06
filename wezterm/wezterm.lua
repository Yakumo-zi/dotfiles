local Config = require('config')

return Config:init()
    :append(require('config.appearance'))
    :append(require('config.fonts'))
    :append(require('config.bindings'))
    :append(require('config.launch'))
    :append(require('config.general'))
    .options
