require "csv"
require "log"
require "colorize"

require "./lib/app.cr"
require "./lib/cli.cr"

LOG = ::Log.for("happy")
#LOG = Logger.new(STDOUT, level: Logger::WARN)

HappyCli.start(ARGV)
