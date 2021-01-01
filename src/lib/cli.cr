
require "clim"

class HappyCli < Clim
  main do
    desc "Happy Send - Mass send short text messages via your smartphone + kdeconnect"

    usage "happy-send [options] [arguments] ..."

    option "-s", "--send",
      type: Bool,
      default: false,
      desc: "Send message for real (=not dry-run)"

    option "-w", "--wait=SECONDS",
      type: Int32,
      default: 5,
      desc: "Wait SECONDS between each message (default: 5)"

    option "-v", "--verbose", 
      type: Bool,
      default: false,
      desc: "Enable debug messages"

    option "-c FILE", "--csv=FILE", 
      type: String,
      required: true,
      desc: "Use given CSV (mandatory fields: number,message)"

    run do |opts, args|
      Log.setup(:warn)
      Log.setup(:debug) if opts.verbose

      if opts.send
        Log.warn { "Disabling dry-run mode : messages will be sent !" }
        STDERR.puts "Disabling dry-run mode. Type 'yes' to confirm or anything else to exit"
        if STDIN.gets.to_s.strip != "yes"
          Log.warn { "Disabling dry-run was not confirmed. Exiting" }
          exit 1
        end
      end

      app = HappyApp.new(csv: opts.csv, send: opts.send, wait: opts.wait)
      app.detect_device
      app.validate
      app.exec
    end
  end
end
