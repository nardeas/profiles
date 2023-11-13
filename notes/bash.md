# Notes/ bash

## Searching

> Recursively search for "oldtext" and replace with "newtext" in files
```
grep -rl "oldtext" . | xargs sed -i "" -e 's/oldtext/newtext/g'
```
