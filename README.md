In a nutshell it's just a `sys->fprint(sys->fildes(2), "...")` implemented as separate module, which you have to load, init, and setup before calling that fprint. And here is features you get in return:

  * 5 log levels: ERR, WARN, NOTICE, INFO, DEBUG
  * default log level set from environment variable $loglevel
  * prefix output messages with:
    * application name (optional)
    * module/subsystem name (optional)
    * log level
  * log messages from 3rd-party module (which also use this logger) will include your application name when that module was loaded by your application


---


To install make directory with this module available in /opt/powerman/logger/, for ex.:

```
# hg clone https://inferno-contrib-logger.googlecode.com/hg/ $INFERNO_ROOT/opt/powerman/logger
```

or in user home directory:

```
$ hg clone https://inferno-contrib-logger.googlecode.com/hg/ $INFERNO_USER_HOME/opt/powerman/logger
$ emu
; bind opt /opt
```