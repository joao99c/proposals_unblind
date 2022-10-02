# config/initializers/grover.rb
Grover.configure do |config|
  config.options = {
    format: 'A4',
    margin: {
      top: '0',
      bottom: '0',
      left:'0',
      right:'0'
    },
    user_agent: 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:47.0) Gecko/20100101 Firefox/47.0',
    viewport: {
      width: 640,
      height: 480
    },
    prefer_css_page_size: false,
    emulate_media: 'screen',
    bypass_csp: true,
    media_features: [{ name: 'prefers-color-scheme', value: 'dark' }],
    timezone: 'Europe/Lisbon',
    cache: true,
    timeout: 0, # Timeout in ms. A value of `0` means 'no timeout'
    request_timeout: 10_000, # Timeout when fetching the content (overloads the `timeout` option)
    convert_timeout: 10_000, # Timeout when converting the content (overloads the `timeout` option, only applies to PDF conversion)
    launch_args: ['--font-render-hinting=medium'],
    print_background: true
  }
end