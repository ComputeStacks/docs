# ComputeStacks mkdocs Doc Repo

## Installation
`pip install -r requirements.txt`

Upgrade with: `pip install -r requirements.txt -U`

## Deploying

```bash
rsync -e 'ssh -p 18143' -aP site/ sftpuser@51.161.105.194:apps/boring-blackwell52/webroot/
```
