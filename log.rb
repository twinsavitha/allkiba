 require 'logging'

  # here we setup a color scheme called 'bright'
  Logging.color_scheme( 'bright',
    :levels => {
      :info  => :green,
      :warn  => :yellow,
      :error => :red,
      :fatal => [:white, :on_red]
    },
    :date => :blue,
    :logger => :cyan,
    :message => :magenta
  )

  Logging.appenders.stdout(
    'stdout',
    :layout => Logging.layouts.pattern(
      :pattern => '[%d] %-5l %c: %m\n',
      :color_scheme => 'bright'
    )
  )

  log = Logging.logger['Happy::Colors']
  log.appenders = Logging.appenders.file('newoutput.log')
  log.level = :debug

  # these log messages will be nicely colored
  # the level will be colored differently for each message
  #
  log.debug "a very nice little debug message"
  log.info "things are operating nominally"
  log.warn "this is your last warning"
  log.error StandardError.new("something went horribly wrong")
  log.fatal "I Die!"


Logging.logger['Critical'].info 'just keeping you informed'
  Logging.logger['Critical'].fatal 'WTF!!'