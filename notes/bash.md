# Notes/ bash

## Searching

> Recursively search for "oldtext" and replace with "newtext" in files
```
grep -rl "oldtext" . | xargs sed -i "" -e 's/oldtext/newtext/g'
```

> Follow cmake logs with a highlight
```
tail -f ~/Library/Logs/Homebrew/<package name>/02.cmake.log|GREP_COLOR='01;32' /usr/bin/grep --color=auto -E '\[(.+)\]'
```
