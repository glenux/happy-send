![Build](https://github.com/glenux/happy-send/workflows/Build/badge.svg?branch=master)
[![GitHub license](https://img.shields.io/github/license/glenux/happy-send.svg)](https://github.com/glenux/happy-send/blob/master/LICENSE.txt)
[![Donate on patreon](https://img.shields.io/badge/patreon-donate-orange.svg)](https://patreon.com/glenux)

> :information_source: This project is available on our self-hosted server and
> on CodeBerg and GitHub as mirrors. For the latest updates and comprehensive
> version of our project, please visit our primary repository at:
> <https://code.apps.glenux.net/glenux/happy-send>.

# HappySend

HappySend is a tool that makes it easy to send wishes to lots of people through short text messages.

It simply parses a CSV file and uses [KDE Connect](https://community.kde.org/KDEConnect) command line tool to control your smartphone.


## Installation

1. Make sure that a recent version of Crystal (0.35) is installed
2. Make sure that kdeconnect-cli is installed

Then run the following commands :

    $ shards install
    $ make build

That should create the binary `_build/happy-send`

## Usage

### Available options


    Happy Send - Mass send short text messages via your smartphone + kdeconnect
  
    Usage:
  
      happy-send [options] [arguments]
  
    Options:
  
      -s, --send                       Send message for real (=not dry-run) [type:Bool] [default:false]
      -w, --wait=SECONDS               Wait SECONDS between each message (default: 5) [type:Int32] [default:5]
      -v, --verbose                    Enable debug messages [type:Bool] [default:false]
      -c FILE, --csv=FILE              Use given CSV (mandatory fields: number,message) [type:String] [required]
      --help                           Show this help.



### Preparing your file

Fill a CSV file respecting the structure below. Note you can insert variables from
other columns within your message.

    "group","firstname","lastname","number","message"
    "MAINTAINER","Glenn","Rolland","+33673983956","Happy new year {{ firstname }} !"
    "HEROES","Jon","Snow","+33xxxxxx","Happy new year {{ firstname }} ! Winter is coming."
    "HEROES","Harry","Potter","+32xxxxxx","Happy new year {{ firstname }} ! Expecto patronum in 2021 !"
    "HEROES","Luke","Skywalker","+33xxxxxx","Happy new year {{ firstname }} ! May the force be with you in 2021"

Verify what will be done with the following command. No message will be sent yet :

    $ _build/happy-send --csv config/friends.csv

###  Sending the messages !

Make sure your that

1. Your smartphone has the KDE Connect app installed. 
2. Your smartphone is connected on the same wifi network as your computer

Verify that your computer is able to detect your smartphone

    $ kdeconnect-cli -a
    - Galaxy S8: b4fade0a33cdf703 (paired and reachable)
    1 device found

If it is ok for you, launch it for real :

    $ _build/happy-send --send --csv config/friends.csv


## Contributing

1. Fork it ( http://github.com/glenux/happy-send/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## Credits

* [Glenn Y. ROLLAND](https://github.com/glenux) - author & maintainer:
* You? Fork the project and become a contributor!

Got questions? Need help? Tweet at [@glenux](https://twitter.com/glenux)


## License

Happy Send is Copyright © 2018-2019 Glenn ROLLAND. It is free software, and may be redistributed under the terms specified in the LICENSE.txt file.

