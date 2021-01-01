
require "crustache"

class HappyApp 
  def initialize(csv = "", wait = 5, send = false)
    @config = csv
    @wait = wait
    @send = send
    @device = ""
  end

  def validate()
    if File.exists? @config
      LOG.info { "Found configuration file '#{@config}'. Good." }
    else
      LOG.error { "ERROR: configuration file '#{@config}' does not exist!" }
      exit 1
    end

    if !@device.to_s.empty?
      LOG.info { "Found device '#{@device}'. Good." }
    else
      LOG.error { "ERROR: unable to detect kdeconnect device!" }
      exit 1
    end
  end

  def detect_device() 
    @device = `kdeconnect-cli --list-available --id-only`.strip
  end

  def send_message(row_h)
    template = Crustache.parse row_h["message"]
    row_h["message"] = Crustache.render template, row_h
    LOG.debug { "Rendered text = #{row_h["message"]}" }

    if !@send
      LOG.warn { "Dry-run mode. Not sending message for #{row_h.values}" }
      return
    end

    LOG.warn { "Sending message for #{row_h.values}" }
    res = Process.run(
      "kdeconnect-cli", 
      [
        "--device", @device,
        "--destination", row_h["number"],
        "--send-sms", row_h["message"]
      ],
      output: STDOUT,
      input: STDIN,
      error: STDERR
    )
    if !res.success?
      LOG.warn { "Command status error for #{row_h.values}" }
    end

  rescue e
    LOG.error { "Error while sending message for #{row_h.values}. #{e.message}" }
  end

  def exec()
    File.open(@config) do |csv_fh|
      csv = CSV.new(csv_fh, headers: true, strip: true)
      # puts csv.inspect
      csv.each do |row_strip|
        row = row_strip.row
        row_h = row.to_h

        if row["firstname"] =~ /^\s*$/ || row["firstname"] =~ /^#.*$/ 
            LOG.debug { "Skipping line for #{row_h.values}" }
          next
        end

        # Check number
        if row["number"].empty?
          LOG.warn { "Missing number for #{row_h.values}. Skipping" }
          next
        end
        row_h["number"] = row["number"].gsub(/\s+/,"")

        send_message(row_h)
        sleep @wait

      end
      puts "SUCCESS"
    end
  end
end

