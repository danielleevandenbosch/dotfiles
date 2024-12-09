local dap = require('dap')

-- PHP Debug Adapter setup
dap.adapters.php = {
    type = 'executable',
    command = 'node',
    args = { '/var/www/vscode-php-debug/out/phpDebug.js' },
}

-- PHP Debugger configuration
dap.configurations.php = {
    {
        type = 'php',
        request = 'launch',
        name = 'Listen for Xdebug',
        port = 9003,
        pathMappings = {
            ['/var/www/html'] = '/var/www/html', -- Remote to local mapping
        },
    },
}

