# Notes/ SSH

## Multi-hop file transfer

```
scp -o ProxyCommand="ssh <remote user>@<remote server 1> nc <remote server 2> 22" <local file path> <remote user>@<remote server 2>:<remote file path>
```

## Multi-hop tunnel remote to local port

> add `-fN` for daemon mode

```
ssh -L <local port>:<remote name>.cloud-internal:<remote port> <bastion user>@<bastion host>
```
