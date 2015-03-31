# Description

In a nutshell it's just a `sys->fprint(sys->fildes(2), "...")` implemented
as separate module, which you have to load, init, and setup before calling
that fprint. And here is features you get in return:

* 5 log levels: ERR, WARN, NOTICE, INFO, DEBUG
* default log level set from environment variable $loglevel
* prefix output messages with:
  * application name (optional)
  * module/subsystem name (optional)
  * log level
* log messages from 3rd-party module (which also use this logger) will
  include your application name when that module was loaded by your
  application


# Install

Make directory with this module available in /opt/powerman/logger/.

Install system-wide:

```
# git clone https://github.com/powerman/inferno-contrib-logger.git $INFERNO_ROOT/opt/powerman/logger
```

or in your home directory:

```
$ git clone https://github.com/powerman/inferno-contrib-logger.git $INFERNO_USER_HOME/opt/powerman/logger
$ emu
; bind opt /opt
```

or locally for your project:

```
$ git clone https://github.com/powerman/inferno-contrib-logger.git $YOUR_PROJECT_DIR/opt/powerman/logger
$ emu
; cd $YOUR_PROJECT_DIR_INSIDE_EMU
; bind opt /opt
```

If you want to run commands and read man pages without entering full path
to them (like `/opt/VENDOR/APP/dis/cmd/NAME`) you should also install and
use https://github.com/powerman/inferno-opt-setup 

