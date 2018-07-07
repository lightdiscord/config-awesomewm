local notify = require('../../utils/notify_error')

local in_error = false

local function error(err)
    print('error1')
    if in_error then return end
    in_error = true

    print('error2')

    notify('Oops, an error happened!', tostring(err))

    in_error = false
end

awesome.connect_signal('debug::error', error)